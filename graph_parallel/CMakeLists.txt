# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostGraphParallel
  DEPENDS
    BoostGraph
    BoostMPI
    BoostUtility
    BoostSerialization
    MPI
)

if (${RYPPL_BoostGraphParallel_VALID})

include_directories(
  ${MPI_INCLUDE_PATH}
  include
  )

if(MSVC)
  add_definitions(
    /wd4251 # class needs to have dll-interface to be used by clients
    /wd4275 # non dll-interface class used as base for dll-interface class
    /wd4800 # forcing value to bool 'true' or 'false' (performance warning)
    )
endif(MSVC)

add_library(boost_graph_parallel
  src/mpi_process_group.cpp
  src/tag_allocator.cpp
  )

target_link_libraries(boost_graph_parallel
  boost_mpi
  # <define>BOOST_GRAPH_NO_LIB=1
  # <link>shared:<define>BOOST_GRAPH_DYN_LINK=1
  # <toolset>intel-vc71-win-9.1:<optimization>off
  # <toolset>msvc-7.1:<cxxflags>-GR-
)

endif()

ryppl_export(
  TARGETS
    boost_graph_parallel
  DEPENDS
    BoostConceptCheck
    BoostConfig
    BoostConversion
    BoostCore
    BoostDisjointSets
    BoostDynamicBitset
    BoostFilesystem
    BoostForeach
    BoostFunction
    BoostFunctionalHash
    BoostGraph
    BoostInteger
    BoostIterator
    BoostMPI
    BoostMPL
    BoostOptional
    BoostPropertyMap
    BoostSmartPtr
    BoostStaticAssert
    BoostTuple
    BoostTypeTraits
    BoostUtility
    BoostVariant
  RECOMMENDS
    BoostRandom
    BoostSerialization
  INCLUDE_DIRECTORIES
    include
  )
