# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostSignals
  DEPENDS
    BoostAny
    BoostConfig
    BoostCore
    BoostFunction
    BoostIterator
    BoostMPL
    BoostOptional
    BoostSmartPtr
    BoostTypeTraits
    BoostUtility
)

ryppl_add_doc_subdirectory(doc)

if(${RYPPL_BoostSignals_VALID})

include_directories(include)

if(MSVC)
  add_definitions(
    /wd4251 # class needs to have dll-interface to be used by clients
    /wd4275 # 'boost::noncopyable' used as base for dll-interface class 
    )
endif(MSVC)

add_library(boost_signals
  src/trackable.cpp
  src/connection.cpp
  src/named_slot_map.cpp
  src/signal_base.cpp
  src/slot.cpp
  )

ryppl_add_test_subdirectory(test)

endif()

ryppl_export(
  TARGETS
    boost_signals
  DEPENDS
    BoostAny
    BoostConfig
    BoostCore
    BoostFunction
    BoostIterator
    BoostMPL
    BoostOptional
    BoostSmartPtr
    BoostTypeTraits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
  )
