# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostMPL)

ryppl_add_test_subdirectory(test)


ryppl_export(
  DEPENDS
    BoostConfig
    BoostCore
    BoostPreprocessor
    BoostStaticAssert
    BoostTypeTraits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
  )
