# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

# TODO C is required for find_package(Threads)
ryppl_project(BoostThread
  DEPENDS
    BoostChrono
    BoostConfig
    BoostDateTime
    BoostSystem
    Threads
)

ryppl_add_doc_subdirectory(doc)

if (${RYPPL_BoostThread_VALID})

include_directories(
  include
  )

if(CMAKE_USE_WIN32_THREADS_INIT)
  set(sources
    src/win32/thread.cpp
    src/win32/tss_dll.cpp
    src/win32/tss_pe.cpp
    )
else()
  set(sources
    src/pthread/thread.cpp
    src/pthread/once.cpp
    )
endif()

add_library(boost_thread
  ${sources}
  )

target_link_libraries(boost_thread
  boost_chrono
  boost_date_time
  ${CMAKE_THREAD_LIBS_INIT}
  )

if(BUILD_SHARED_LIBS)
  set_property(TARGET boost_thread APPEND PROPERTY
    COMPILE_DEFINITIONS "BOOST_THREAD_BUILD_DLL=1"
    )
else()
  set_property(TARGET boost_thread APPEND PROPERTY
    COMPILE_DEFINITIONS "BOOST_THREAD_BUILD_LIB=1"
    )
  set_target_properties(boost_thread PROPERTIES
    PREFIX "lib"
    )
endif()


endif()

ryppl_export(
  TARGETS
    boost_thread
  DEPENDS
    BoostBind
    BoostChrono
    BoostConfig
    BoostContainer
    BoostCore
    BoostDateTime
    BoostException
    BoostFunction
    BoostFunctionalHash
    BoostIO
    BoostInteger
    BoostMPL
    BoostMove
    BoostOptional
    BoostSmartPtr
    BoostStaticAssert
    BoostSystem
    BoostTypeTraits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
  )
