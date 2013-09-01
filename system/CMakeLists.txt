# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostSystem
  DEPENDS
    BoostConfig
    BoostInteger # cstdint.hpp
    BoostUtility # assert.hpp, noncopyable.hpp, enable_if.hpp, operators.hpp
)

if(${RYPPL_BoostSystem_VALID})

include_directories(include)

add_library(boost_system
  src/error_code.cpp
  src/local_free_on_destruction.hpp
  )

if(NOT BUILD_SHARED_LIBS)
  set_target_properties(boost_system PROPERTIES
    PREFIX "lib"
    )
endif(NOT BUILD_SHARED_LIBS)

boost_library_naming(boost_system)

endif()

#add_subdirectory(doc)


ryppl_export(
  TARGETS
    boost_system
  DEPENDS
    BoostConfig
    BoostInteger
    BoostUtility
  INCLUDE_DIRECTORIES
    include
  )
