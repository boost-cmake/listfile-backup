# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostAssign)

ryppl_add_test_subdirectory(test)
ryppl_add_doc_subdirectory(doc)

ryppl_export(
  DEPENDS
    BoostArray
    BoostConfig
    BoostCore
    BoostMPL
    BoostPreprocessor
    BoostPtrContainer
    BoostRange
    BoostStaticAssert
    BoostTuple
    BoostTypeTraits
  INCLUDE_DIRECTORIES
    include
)
