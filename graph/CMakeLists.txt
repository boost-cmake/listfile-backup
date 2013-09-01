# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostGraph
  DEPENDS
    BoostPropertyMap
    BoostPropertyTree
    BoostSerialization
    BoostUtility
    BoostRegex
)

if (${RYPPL_BoostGraph_VALID})


add_library(boost_graph
  src/read_graphviz_new.cpp
  src/graphml.cpp
)

target_link_libraries(boost_graph
  boost_regex
)

endif()

ryppl_export(
  TARGETS
    boost_graph
  DEPENDS
    BoostAlgorithm
    BoostAny
    BoostArray
    BoostBimap
    BoostBind
    BoostConceptCheck
    BoostConfig
    BoostConversion
    BoostCore
    BoostDisjointSets
    BoostException
    BoostForeach
    BoostFunction
    BoostFunctionalHash
    BoostGraphParallel
    BoostInteger
    BoostIterator
    BoostMPL
    BoostMath
    BoostMultiIndex
    BoostOptional
    BoostParameter
    BoostPreprocessor
    BoostPropertyMap
    BoostPropertyTree
    BoostRange
    BoostSmartPtr
    BoostSpiritClassic
    BoostStaticAssert
    BoostTTI
    BoostTuple
    BoostTypeTraits
    BoostTypeof
    BoostUnordered
    BoostUtility
    BoostXpressive
  RECOMMENDS
    BoostRandom
    BoostSerialization
    BoostTest
  INCLUDE_DIRECTORIES
    include
  )
