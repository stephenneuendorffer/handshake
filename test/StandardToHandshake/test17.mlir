// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: handshake-opt -create-dataflow %s | FileCheck %s
func @affine_apply_floordiv(%arg0: index) -> index {
// CHECK:       module {

// CHECK-LABEL:   handshake.func @affine_apply_floordiv(
// CHECK-SAME:                                          %[[VAL_0:.*]]: index, %[[VAL_1:.*]]: none, ...) -> (index, none) {
// CHECK:           %[[VAL_2:.*]] = "handshake.merge"(%[[VAL_0]]) : (index) -> index
// CHECK:           %[[VAL_3:.*]]:3 = "handshake.fork"(%[[VAL_2]]) {control = false} : (index) -> (index, index, index)
// CHECK:           %[[VAL_4:.*]]:4 = "handshake.fork"(%[[VAL_1]]) {control = true} : (none) -> (none, none, none, none)
// CHECK:           %[[VAL_5:.*]] = "handshake.constant"(%[[VAL_4]]#2) {value = 42 : index} : (none) -> index
// CHECK:           %[[VAL_6:.*]] = "handshake.constant"(%[[VAL_4]]#1) {value = 0 : index} : (none) -> index
// CHECK:           %[[VAL_7:.*]] = "handshake.constant"(%[[VAL_4]]#0) {value = -1 : index} : (none) -> index
// CHECK:           %[[VAL_8:.*]]:2 = "handshake.fork"(%[[VAL_7]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_9:.*]] = cmpi "slt", %[[VAL_3]]#2, %[[VAL_6]] : index
// CHECK:           %[[VAL_10:.*]]:2 = "handshake.fork"(%[[VAL_9]]) {control = false} : (i1) -> (i1, i1)
// CHECK:           %[[VAL_11:.*]] = subi %[[VAL_8]]#0, %[[VAL_3]]#1 : index
// CHECK:           %[[VAL_12:.*]] = select %[[VAL_10]]#1, %[[VAL_11]], %[[VAL_3]]#0 : index
// CHECK:           %[[VAL_13:.*]] = divi_signed %[[VAL_12]], %[[VAL_5]] : index
// CHECK:           %[[VAL_14:.*]]:2 = "handshake.fork"(%[[VAL_13]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_15:.*]] = subi %[[VAL_8]]#1, %[[VAL_14]]#1 : index
// CHECK:           %[[VAL_16:.*]] = select %[[VAL_10]]#0, %[[VAL_15]], %[[VAL_14]]#0 : index
// CHECK:           handshake.return %[[VAL_16]], %[[VAL_4]]#3 : index, none
// CHECK:         }
// CHECK:       }
    %c42 = constant 42 : index
    %c0 = constant 0 : index
    %c-1 = constant -1 : index
    %0 = cmpi "slt", %arg0, %c0 : index
    %1 = subi %c-1, %arg0 : index
    %2 = select %0, %1, %arg0 : index
    %3 = divi_signed %2, %c42 : index
    %4 = subi %c-1, %3 : index
    %5 = select %0, %4, %3 : index
    return %5 : index
  }
