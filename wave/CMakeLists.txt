# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostWave
  DEPENDS
    BoostConfig
    BoostThread
    BoostSpirit
    BoostSpiritClassic
)

if (${RYPPL_BoostWave_VALID})

include_directories(
  include
  )

if(MSVC)
  add_definitions(
    -D_CRT_SECURE_NO_WARNINGS
    -D_SCL_SECURE_NO_WARNINGS
    )
endif(MSVC)

add_library(boost_wave
  src/instantiate_cpp_exprgrammar.cpp
  src/instantiate_cpp_grammar.cpp
  src/instantiate_cpp_literalgrs.cpp
  src/instantiate_defined_grammar.cpp
  src/instantiate_predef_macros.cpp
  src/instantiate_re2c_lexer.cpp
  src/instantiate_re2c_lexer_str.cpp
  src/token_ids.cpp
  src/wave_config_constant.cpp
  src/cpplexer/re2clex/aq.cpp
  src/cpplexer/re2clex/cpp_re.cpp
  )

target_link_libraries(boost_wave
  boost_thread
  )

# # wave currently has problems with filesystem3
# add_executable(wave
#   tool/cpp.cpp
#   )
# target_link_libraries(wave
#   boost_wave
#   )


endif()


ryppl_export(
  TARGETS
    boost_wave
    # wave
  DEPENDS
    BoostConceptCheck
    BoostConfig
    BoostCore
    BoostException
    BoostFilesystem
    BoostInteger
    BoostIterator
    BoostMPL
    BoostMultiIndex
    BoostPool
    BoostPreprocessor
    BoostSmartPtr
    BoostSpirit
    BoostSpiritClassic
    BoostStaticAssert
    BoostTypeTraits
    BoostUtility
  RECOMMENDS
    BoostSerialization
  INCLUDE_DIRECTORIES
    include
  )
