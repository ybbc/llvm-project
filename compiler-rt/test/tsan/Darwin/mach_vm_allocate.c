// Test that mach_vm_[de]allocate resets shadow memory status.
//
// RUN: %clang_tsan %s -o %t
// RUN: %run %t 2>&1 | FileCheck %s --implicit-check-not='ThreadSanitizer'

#include <mach/mach.h>
#include <mach/mach_vm.h>
#include <pthread.h>
#include <assert.h>
#include <stdio.h>

#include "../test.h"

const mach_vm_size_t alloc_size = sizeof(int);
static int *global_ptr;
static bool realloc_success = false;

static int *alloc() {
  mach_vm_address_t addr;
  kern_return_t res =
      mach_vm_allocate(mach_task_self(), &addr, alloc_size, VM_FLAGS_ANYWHERE);
  assert(res == KERN_SUCCESS);
  return (int *)addr;
}

static void alloc_fixed(int *ptr) {
  mach_vm_address_t addr = (mach_vm_address_t)ptr;
  // Re-allocation via VM_FLAGS_FIXED sporadically fails.
  kern_return_t res =
      mach_vm_allocate(mach_task_self(), &addr, alloc_size, VM_FLAGS_FIXED);
  realloc_success = res == KERN_SUCCESS;
}

static void dealloc(int *ptr) {
  kern_return_t res =
      mach_vm_deallocate(mach_task_self(), (mach_vm_address_t)ptr, alloc_size);
  assert(res == KERN_SUCCESS);
}

static void *Thread(void *arg) {
  *global_ptr = 7;  // Assignment 1

  // We want to test that TSan does not report a race between the two
  // assignments to *global_ptr when the underlying memory is re-allocated
  // between assignments. The calls to the API itself are racy though, so ignore
  // them.
  AnnotateIgnoreWritesBegin(__FILE__, __LINE__);
  dealloc(global_ptr);
  alloc_fixed(global_ptr);
  AnnotateIgnoreWritesEnd(__FILE__, __LINE__);

  barrier_wait(&barrier);
  return NULL;
}

static void try_realloc_on_same_address() {
  barrier_init(&barrier, 2);
  global_ptr = alloc();
  pthread_t t;
  pthread_create(&t, NULL, Thread, NULL);

  barrier_wait(&barrier);
  *global_ptr = 8;  // Assignment 2

  pthread_join(t, NULL);
  dealloc(global_ptr);
}

int main(int argc, const char *argv[]) {
  for (int i = 0; i < 10; i++) {
    try_realloc_on_same_address();
    if (realloc_success) break;
  }

  if (!realloc_success)
    fprintf(stderr, "Unable to set up testing condition; silently pass test\n");

  printf("Done.\n");
  return 0;
}

// CHECK: Done.
