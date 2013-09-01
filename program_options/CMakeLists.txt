# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostProgramOptions
  DEPENDS
    BoostAny
    BoostBind
    BoostConfig
    BoostConversion
    BoostCore
    BoostException
    BoostFunction
    BoostIterator
    BoostSmartPtr
    BoostStaticAssert
    BoostTokenizer
    BoostTypeTraits
    BoostUtility
)

ryppl_add_doc_subdirectory(doc)

if (${RYPPL_BoostProgramOptions_VALID})

include_directories(include)

add_library(boost_program_options
  src/cmdline
  src/config_file
  src/options_description
  src/parsers
  src/variables_map
  src/value_semantic
  src/positional_options
  src/utf8_codecvt_facet
  src/convert
  src/winmain
  src/split
  )


boost_library_naming(boost_program_options)


endif()

ryppl_export(
  TARGETS
    boost_program_options
  DEPENDS
    BoostAny
    BoostConfig
    BoostConversion
    BoostCore
    BoostException
    BoostFunction
    BoostIterator
    BoostSmartPtr
    BoostStaticAssert
    BoostTypeTraits
    BoostUtility
  INCLUDE_DIRECTORIES
    include
  )
