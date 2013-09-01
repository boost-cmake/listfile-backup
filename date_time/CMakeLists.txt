# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostDateTime
  DEPENDS
    BoostConfig
    BoostTokenizer
)

#ryppl_add_test_subdirectory(test)
ryppl_add_doc_subdirectory(xmldoc)

if (${RYPPL_BoostDateTime_VALID})

include_directories(include)

add_definitions(
  -DDATE_TIME_INLINE
  )

add_library(boost_date_time
  src/gregorian/greg_month.cpp
  src/gregorian/greg_weekday.cpp
  src/gregorian/date_generators.cpp
)

endif()

ryppl_export(
  TARGETS
    boost_date_time
  DEPENDS
    BoostAlgorithm
    BoostConfig
    BoostConversion
    BoostCore
    BoostException
    BoostIO
    BoostInteger
    BoostMPL
    BoostRange
    BoostSmartPtr
    BoostTokenizer
    BoostTypeTraits
    BoostUtility
  RECOMMENDS
    BoostSerialization
  INCLUDE_DIRECTORIES
    include
)
