# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostSignals2)

ryppl_add_test_subdirectory(test)
ryppl_add_doc_subdirectory(doc)

ryppl_export(
  DEPENDS
    BoostAny
    BoostBind
    BoostConfig
    BoostCore
    BoostException
    BoostFunction
    BoostIterator
    BoostMPL
    BoostMultiIndex
    BoostOptional
    BoostParameter
    BoostPreprocessor
    BoostSmartPtr
    BoostTuple
    BoostTypeTraits
    BoostUtility
    BoostVariant
  INCLUDE_DIRECTORIES
    include
)
