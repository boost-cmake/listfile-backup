# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


set(MPIHeaders
  "../include/boost/mpi.hpp"
  "../include/boost/mpi/allocator.hpp"
  "../include/boost/mpi/collectives.hpp"
  "../include/boost/mpi/collectives_fwd.hpp"
  "../include/boost/mpi/communicator.hpp"
  "../include/boost/mpi/config.hpp"
  "../include/boost/mpi/datatype.hpp"
  "../include/boost/mpi/datatype_fwd.hpp"
  "../include/boost/mpi/environment.hpp"
  "../include/boost/mpi/exception.hpp"
  "../include/boost/mpi/graph_communicator.hpp"
  "../include/boost/mpi/group.hpp"
  "../include/boost/mpi/intercommunicator.hpp"
  "../include/boost/mpi/nonblocking.hpp"
  "../include/boost/mpi/operations.hpp"
  "../include/boost/mpi/packed_iarchive.hpp"
  "../include/boost/mpi/packed_oarchive.hpp"
  "../include/boost/mpi/skeleton_and_content.hpp"
  "../include/boost/mpi/skeleton_and_content_fwd.hpp"
  "../include/boost/mpi/status.hpp"
  "../include/boost/mpi/request.hpp"
  "../include/boost/mpi/timer.hpp"
  "../include/boost/mpi/python.hpp"
)

set(DoxygenParameters
  MACRO_EXPANSION=YES
  EXPAND_ONLY_PREDEF=YES
  "PREDEFINED=BOOST_MPI_HAS_MEMORY_ALLOCATION= BOOST_MPI_HAS_NOARG_INITIALIZATION= MPI_VERSION=2 BOOST_MPI_DOXYGEN="
)



set(mpi_autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/mpi_autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${MPIHeaders}
  OUTPUT
    ${mpi_autodoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)

set(mpi_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/mpi_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/mpi.qbk
  ${mpi_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(mpi_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/mpi.xml)
export_documentation(
  mpi
  BOOSTBOOK
    ${mpi_gen_bbk_xml}
  DEPENDS
    ${mpi_autodoc_bbk_xml}
)
