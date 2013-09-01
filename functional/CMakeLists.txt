# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostFunctional)

ryppl_add_test_subdirectory(test)

add_subdirectory(factory)
add_subdirectory(forward)
add_subdirectory(overloaded_function)


ryppl_export(
  DEPENDS
    BoostConfig
    BoostCore
    BoostFunction
    BoostFunctionTypes
    BoostIterator
    BoostMPL
    BoostOptional
    BoostPreprocessor
    BoostSmartPtr
    BoostTypeTraits
    BoostTypeof
    BoostUtility
  INCLUDE_DIRECTORIES
    include
)
