// RUN: llvm-mc -filetype=obj -triple=x86_64-pc-linux %s -o %t.o
// RUN: lld -flavor gnu2 %t.o -shared -soname=foo.so -o %t
// RUN: llvm-readobj --dynamic-table %t | FileCheck %s

// CHECK: 0x000000000000000E SONAME  LibrarySoname (foo.so)

.global _start
_start:
