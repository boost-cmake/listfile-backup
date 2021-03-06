# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostGeometry)

set(BOOST_GEOMETRY_ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

ryppl_add_doc_subdirectory(doc)

ryppl_export(
  DEPENDS
    BoostAlgorithm
    BoostArray
    BoostConceptCheck
    BoostConfig
    BoostConversion
    BoostCore
    BoostForeach
    BoostFunctionTypes
    BoostFusion
    BoostInteger
    BoostIterator
    BoostMPL
    BoostMath
    BoostMsm
    BoostNumericConversion
    BoostPolygon
    BoostRange
    BoostRational
    BoostSmartPtr
    BoostStaticAssert
    BoostTokenizer
    BoostTuple
    BoostTypeTraits
    BoostTypeof
    BoostUBLAS
    BoostUnits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
  )
