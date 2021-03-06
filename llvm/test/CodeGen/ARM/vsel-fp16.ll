; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=armv8a--none-eabi -mattr=+fullfp16 -float-abi=hard | FileCheck %s

@varhalf = global half 0.0
@vardouble = global double 0.0
define void @test_vsel32sgt(i32 %lhs, i32 %rhs, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32sgt:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %tst1 = icmp sgt i32 %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32sge(i32 %lhs, i32 %rhs, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32sge:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %tst1 = icmp sge i32 %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32eq(i32 %lhs, i32 %rhs, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32eq:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vseleq.f16 s0, s0, s2
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %tst1 = icmp eq i32 %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32slt(i32 %lhs, i32 %rhs, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32slt:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vselge.f16 s0, s2, s0
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %tst1 = icmp slt i32 %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32sle(i32 %lhs, i32 %rhs, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32sle:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    cmp r0, r1
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vselgt.f16 s0, s2, s0
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %tst1 = icmp sle i32 %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ogt(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ogt:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp ogt half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32oge(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32oge:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp oge half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32oeq(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32oeq:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vseleq.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp oeq half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ugt(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ugt:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp ugt half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32uge(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32uge:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp uge half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32olt(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32olt:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp olt half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ult(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ult:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp ult half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ole(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ole:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp ole half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ule(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ule:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp ule half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ord(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ord:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselvs.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp ord half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32une(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32une:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vseleq.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp une half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32uno(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32uno:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselvs.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp uno half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}


define void @test_vsel32ogt_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ogt_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan ogt half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32oge_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32oge_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan oge half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32oeq_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32oeq_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vseleq.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan oeq half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ugt_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ugt_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan ugt half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32uge_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32uge_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan uge half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32olt_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32olt_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan olt half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ult_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ult_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselgt.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan ult half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ole_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ole_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan ole half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ule_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ule_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s6, s4
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselge.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan ule half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32ord_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32ord_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselvs.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan ord half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32une_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32une_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vseleq.f16 s0, s2, s0
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan une half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}

define void @test_vsel32uno_nnan(half* %lhs_ptr, half* %rhs_ptr, half* %a_ptr, half* %b_ptr) {
; CHECK-LABEL: test_vsel32uno_nnan:
; CHECK:       @ %bb.0:
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vldr.16 s2, [r3]
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vldr.16 s6, [r1]
; CHECK-NEXT:    movw r0, :lower16:varhalf
; CHECK-NEXT:    vcmp.f16 s4, s6
; CHECK-NEXT:    movt r0, :upper16:varhalf
; CHECK-NEXT:    vmrs APSR_nzcv, fpscr
; CHECK-NEXT:    vselvs.f16 s0, s0, s2
; CHECK-NEXT:    vstr.16 s0, [r0]
; CHECK-NEXT:    bx lr
  %a = load volatile half, half* %a_ptr
  %b = load volatile half, half* %b_ptr
  %lhs = load volatile half, half* %lhs_ptr
  %rhs = load volatile half, half* %rhs_ptr
  %tst1 = fcmp nnan uno half %lhs, %rhs
  %val1 = select i1 %tst1, half %a, half %b
  store half %val1, half* @varhalf
  ret void
}
