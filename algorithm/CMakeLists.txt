# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)


add_subdirectory(string)
add_subdirectory(minmax)

include(Ryppl)

ryppl_project(BoostAlgorithm)

ryppl_add_doc_subdirectory(doc)
ryppl_add_test_subdirectory(test)

ryppl_export(
  DEPENDS
    BoostArray
    BoostConceptCheck
    BoostConfig
    BoostCore
    BoostException
    BoostFunction
    BoostIterator
    BoostMPL
    BoostRange
    BoostStaticAssert
    BoostTR1
    BoostTuple
    BoostTypeTraits
    BoostUtility
  RECOMMENDS
    BoostRegex
  INCLUDE_DIRECTORIES
    include
  )
