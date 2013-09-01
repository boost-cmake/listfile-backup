# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostRandom
  DEPENDS
    BoostConfig
)

if(${RYPPL_BoostRandom_VALID})

add_library(boost_random
  src/random_device.cpp
)

ryppl_add_doc_subdirectory(doc)
ryppl_add_test_subdirectory(test)

endif()

ryppl_export(
  TARGETS
    boost_random
  DEPENDS
    BoostConfig
    BoostCore
    BoostInteger
    BoostMPL
    BoostMath
    BoostRange
    BoostStaticAssert
    BoostTypeTraits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
)
