# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



file(GLOB InterprocessHeaders
  "../include/boost/interprocess/*.hpp"
  "../include/boost/interprocess/allocators/*.hpp"
  "../include/boost/interprocess/containers/*.hpp"
  "../include/boost/interprocess/indexes/*.hpp "
  "../include/boost/interprocess/ipc/*.hpp"
  "../include/boost/interprocess/mem_algo/*.hpp"
  "../include/boost/interprocess/smart_ptr/*.hpp"
  "../include/boost/interprocess/streams/*.hpp"
  "../include/boost/interprocess/sync/*.hpp"
)

set(DoxygenParameters
  EXTRACT_ALL=NO
  HIDE_UNDOC_MEMBERS=YES
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  EXPAND_ONLY_PREDEF=YES
  MACRO_EXPANSION=YES
  "PREDEFINED=\"BOOST_INTERPROCESS_DOXYGEN_INVOKED\" \\
    \"BOOST_CONTAINER_NOEXCEPT_IF(a)=\" \\
    \"BOOST_CONTAINER_NOEXCEPT=\" \\
    \"BOOST_INTERPROCESS_ENABLE_MOVE_EMULATION(a)= \" \\
    \"BOOST_RV_REF(a)=a &&\" \\
    \"BOOST_RV_REF_2_TEMPL_ARGS(a,b,c)=a &&\" \\
    \"BOOST_RV_REF_3_TEMPL_ARGS(a,b,c,d)=a &&\" \\
    \"BOOST_FWD_REF(a)=a &&\""
)



set(autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${InterprocessHeaders}
  OUTPUT
    ${autodoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Boost.Interprocess Reference"
)

set(ipc_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/interprocess_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/interprocess.qbk
  ${ipc_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/index.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/
)

set(HtmlParameters
  boost.root=../../../..
  boost.libraries=../../../../libs/libraries.htm
  toc.max.depth=1
  toc.section.depth=2
  chunk.first.sections=1
  chunk.section.depth=2
)

export_documentation(
  interprocess
  BOOSTBOOK
    ${ipc_gen_bbk_xml}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
  DEPENDS
    ${autodoc_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
