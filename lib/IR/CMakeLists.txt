set(LLVM_OPTIONAL_SOURCES
  DialectRegistration.cpp
  HandshakeOps.cpp
  mlir_std_runner.cpp
  )

add_mlir_dialect_library(MLIRHandshakeOps
#  DialectRegistration.cpp
  HandshakeOps.cpp

  ADDITIONAL_HEADER_DIRS
  ${PROJECT_SOURCE_DIR}/include
  ${PROJECT_BINARY_DIR}/include

  LINK_LIBS
  MLIRStandardOps
  MLIRIR
  )
add_dependencies(MLIRHandshakeOps
  MLIRHandshakeOpsIncGen
  MLIRHandshakeInterfacesIncGen
  MLIRHandshakeRewritersIncGen
  )

set(LIBS
  MLIRAnalysis
  MLIREDSC
  MLIRExecutionEngine
  MLIRHandshakeOps
  MLIRHPXOps
  MLIRIR
  MLIRLLVMIR
  MLIRParser
  MLIRTargetLLVMIR
  MLIRStandardOps
  MLIRSupport
  LLVMCore
  LLVMSupport
  )

#add_llvm_executable(mlir - std - runner
#mlir_std_runner.cpp
#)
#whole_archive_link(mlir - std - runner ${LIBS})
#target_link_libraries(mlir - std - runner PRIVATE ${LIBS})
