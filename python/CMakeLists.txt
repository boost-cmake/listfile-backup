# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostPython
  DEPENDS
    BoostBind
    BoostConfig
    BoostConversion
    BoostCore
    BoostForeach
    BoostFunction
    BoostGraph
    BoostInteger
    BoostIterator
    BoostMPL
#    BoostNumeric
    BoostPreprocessor
    BoostPropertyMap
    BoostSerialization
    BoostSmartPtr
    BoostStaticAssert
    BoostTuple
    BoostTypeTraits
    BoostUtility
    PythonLibs
)

if (${RYPPL_BoostPython_VALID})

include_directories(
  ${PYTHON_INCLUDE_DIRS}
  include
  )

add_library(boost_python
  src/numeric.cpp
  src/list.cpp
  src/long.cpp
  src/dict.cpp
  src/tuple.cpp
  src/str.cpp
  src/slice.cpp
  src/converter/from_python.cpp
  src/converter/registry.cpp
  src/converter/type_id.cpp
  src/object/enum.cpp
  src/object/class.cpp
  src/object/function.cpp
  src/object/inheritance.cpp
  src/object/life_support.cpp
  src/object/pickle_support.cpp
  src/errors.cpp
  src/module.cpp
  src/converter/builtin_converters.cpp
  src/converter/arg_to_python_base.cpp
  src/object/iterator.cpp
  src/object/stl_iterator.cpp
  src/object_protocol.cpp
  src/object_operators.cpp
  src/wrapper.cpp
  src/import.cpp
  src/exec.cpp
  src/object/function_doc_signature.cpp
  )

set_property(TARGET boost_python APPEND PROPERTY
  COMPILE_DEFINITIONS BOOST_PYTHON_SOURCE
  )

target_link_libraries(boost_python
  ${PYTHON_LIBRARIES}
  )

if(NOT BUILD_SHARED_LIBS)
  set_target_properties(boost_python PROPERTIES
    PREFIX "lib"
    )
  set_property(TARGET boost_python APPEND PROPERTY
    COMPILE_DEFINITIONS "BOOST_PYTHON_STATIC_LIB=1"
    )
endif(NOT BUILD_SHARED_LIBS)


endif()

ryppl_export(
  TARGETS
    boost_python
  DEPENDS
    BoostBind
    BoostConfig
    BoostConversion
    BoostCore
    BoostForeach
    BoostFunction
    BoostIterator
    BoostMPL
    BoostNumericConversion
    BoostPreprocessor
    BoostSmartPtr
    BoostStaticAssert
    BoostTuple
    BoostTypeTraits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
)
