//===- OperationSupportTest.cpp - Operation support unit tests ------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#include "mlir/IR/OperationSupport.h"
#include "mlir/IR/Builders.h"
#include "mlir/IR/StandardTypes.h"
#include "gtest/gtest.h"

using namespace mlir;
using namespace mlir::detail;

static Operation *createOp(MLIRContext *context,
                           ArrayRef<Value> operands = llvm::None,
                           ArrayRef<Type> resultTypes = llvm::None) {
  context->allowUnregisteredDialects();
  return Operation::create(UnknownLoc::get(context),
                           OperationName("foo.bar", context), resultTypes,
                           operands, llvm::None, llvm::None, 0);
}

namespace {
TEST(OperandStorageTest, NonResizable) {
  MLIRContext context;
  Builder builder(&context);

  Operation *useOp =
      createOp(&context, /*operands=*/llvm::None, builder.getIntegerType(16));
  Value operand = useOp->getResult(0);

  // Create a non-resizable operation with one operand.
  Operation *user = createOp(&context, operand, builder.getIntegerType(16));

  // The same number of operands is okay.
  user->setOperands(operand);
  EXPECT_EQ(user->getNumOperands(), 1u);

  // Removing is okay.
  user->setOperands(llvm::None);
  EXPECT_EQ(user->getNumOperands(), 0u);

  // Destroy the operations.
  user->destroy();
  useOp->destroy();
}

TEST(OperandStorageTest, Resizable) {
  MLIRContext context;
  Builder builder(&context);

  Operation *useOp =
      createOp(&context, /*operands=*/llvm::None, builder.getIntegerType(16));
  Value operand = useOp->getResult(0);

  // Create a resizable operation with one operand.
  Operation *user = createOp(&context, operand, builder.getIntegerType(16));

  // The same number of operands is okay.
  user->setOperands(operand);
  EXPECT_EQ(user->getNumOperands(), 1u);

  // Removing is okay.
  user->setOperands(llvm::None);
  EXPECT_EQ(user->getNumOperands(), 0u);

  // Adding more operands is okay.
  user->setOperands({operand, operand, operand});
  EXPECT_EQ(user->getNumOperands(), 3u);

  // Destroy the operations.
  user->destroy();
  useOp->destroy();
}

} // end namespace
