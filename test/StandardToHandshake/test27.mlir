// NOTE: Assertions have been autogenerated by utils/update_mlir_test_checks.py
// RUN: handshake-opt -create-dataflow %s | FileCheck %s
func @simple_loop() {
// CHECK:       module {

// CHECK-LABEL:   handshake.func @simple_loop(
// CHECK-SAME:                                %[[VAL_0:.*]]: none, ...) -> none {
// CHECK:           %[[VAL_1:.*]] = "handshake.branch"(%[[VAL_0]]) {control = true} : (none) -> none
// CHECK:           "handshake.terminator"()[^bb1] : () -> ()
// CHECK:         ^bb1:
// CHECK:           %[[VAL_2:.*]]:2 = "handshake.control_merge"(%[[VAL_1]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_3:.*]]:2 = "handshake.fork"(%[[VAL_2]]#0) {control = true} : (none) -> (none, none)
// CHECK:           "handshake.sink"(%[[VAL_2]]#1) : (index) -> ()
// CHECK:           %[[VAL_4:.*]] = "handshake.constant"(%[[VAL_3]]#0) {value = 1 : index} : (none) -> index
// CHECK:           %[[VAL_5:.*]]:2 = "handshake.fork"(%[[VAL_4]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_6:.*]] = "handshake.branch"(%[[VAL_3]]#1) {control = true} : (none) -> none
// CHECK:           %[[VAL_7:.*]] = "handshake.branch"(%[[VAL_5]]#0) {control = false} : (index) -> index
// CHECK:           %[[VAL_8:.*]] = "handshake.branch"(%[[VAL_5]]#1) {control = false} : (index) -> index
// CHECK:           "handshake.terminator"()[^bb2] : () -> ()
// CHECK:         ^bb2:
// CHECK:           %[[VAL_9:.*]] = "handshake.mux"(%[[VAL_10:.*]]#1, %[[VAL_11:.*]], %[[VAL_8]]) : (index, index, index) -> index
// CHECK:           %[[VAL_12:.*]]:2 = "handshake.fork"(%[[VAL_9]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_13:.*]]:2 = "handshake.control_merge"(%[[VAL_14:.*]], %[[VAL_6]]) {control = true} : (none, none) -> (none, index)
// CHECK:           %[[VAL_10]]:2 = "handshake.fork"(%[[VAL_13]]#1) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_15:.*]] = "handshake.mux"(%[[VAL_10]]#0, %[[VAL_16:.*]], %[[VAL_7]]) : (index, index, index) -> index
// CHECK:           %[[VAL_17:.*]]:2 = "handshake.fork"(%[[VAL_15]]) {control = false} : (index) -> (index, index)
// CHECK:           %[[VAL_18:.*]] = cmpi "slt", %[[VAL_17]]#1, %[[VAL_12]]#1 : index
// CHECK:           %[[VAL_19:.*]]:3 = "handshake.fork"(%[[VAL_18]]) {control = false} : (i1) -> (i1, i1, i1)
// CHECK:           %[[VAL_20:.*]], %[[VAL_21:.*]] = "handshake.conditional_branch"(%[[VAL_19]]#2, %[[VAL_12]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_21]]) : (index) -> ()
// CHECK:           %[[VAL_22:.*]], %[[VAL_23:.*]] = "handshake.conditional_branch"(%[[VAL_19]]#1, %[[VAL_13]]#0) {control = true} : (i1, none) -> (none, none)
// CHECK:           %[[VAL_24:.*]], %[[VAL_25:.*]] = "handshake.conditional_branch"(%[[VAL_19]]#0, %[[VAL_17]]#0) {control = false} : (i1, index) -> (index, index)
// CHECK:           "handshake.sink"(%[[VAL_25]]) : (index) -> ()
// CHECK:           "handshake.terminator"()[^bb3, ^bb4] : () -> ()
// CHECK:         ^bb3:
// CHECK:           %[[VAL_26:.*]] = "handshake.merge"(%[[VAL_24]]) : (index) -> index
// CHECK:           %[[VAL_27:.*]] = "handshake.merge"(%[[VAL_20]]) : (index) -> index
// CHECK:           %[[VAL_28:.*]]:2 = "handshake.control_merge"(%[[VAL_22]]) {control = true} : (none) -> (none, index)
// CHECK:           %[[VAL_29:.*]]:2 = "handshake.fork"(%[[VAL_28]]#0) {control = true} : (none) -> (none, none)
// CHECK:           "handshake.sink"(%[[VAL_28]]#1) : (index) -> ()
// CHECK:           %[[VAL_30:.*]] = "handshake.constant"(%[[VAL_29]]#0) {value = 1 : index} : (none) -> index
// CHECK:           %[[VAL_31:.*]] = addi %[[VAL_26]], %[[VAL_30]] : index
// CHECK:           %[[VAL_11]] = "handshake.branch"(%[[VAL_27]]) {control = false} : (index) -> index
// CHECK:           %[[VAL_14]] = "handshake.branch"(%[[VAL_29]]#1) {control = true} : (none) -> none
// CHECK:           %[[VAL_16]] = "handshake.branch"(%[[VAL_31]]) {control = false} : (index) -> index
// CHECK:           "handshake.terminator"()[^bb2] : () -> ()
// CHECK:         ^bb4:
// CHECK:           %[[VAL_32:.*]]:2 = "handshake.control_merge"(%[[VAL_23]]) {control = true} : (none) -> (none, index)
// CHECK:           "handshake.sink"(%[[VAL_32]]#1) : (index) -> ()
// CHECK:           handshake.return %[[VAL_32]]#0 : none
// CHECK:         }
// CHECK:       }
^bb0:
  br ^bb1
^bb1:	// pred: ^bb0
  %c1 = constant 1 : index
  br ^bb2(%c1 : index)
^bb2(%0: index):	// 2 preds: ^bb1, ^bb3
  %1 = cmpi "slt", %0, %c1 : index
  cond_br %1, ^bb3, ^bb4
^bb3:	// pred: ^bb2
  %c1_0 = constant 1 : index
  %2 = addi %0, %c1_0 : index
  br ^bb2(%2 : index)
^bb4:	// pred: ^bb2
  return
}