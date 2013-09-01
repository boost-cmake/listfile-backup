# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



file(GLOB IclHeaders
  "../include/boost/icl/*.hpp"
)

set(DoxygenParameters
  EXTRACT_ALL=YES
  HIDE_UNDOC_MEMBERS=NO
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=NO
  EXPAND_ONLY_PREDEF=YES
  SEARCH_INCLUDES=NO
)


set(icldoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/icldoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${IclHeaders}
  OUTPUT
    ${icldoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Interval Container Library Reference"
)



set(icc_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/icl_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/icl.qbk
  ${icc_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)

set (HtmlParameters
  boost.root=../../../..
  boost.libraries=../../../libraries.htm
  toc.max.depth=2
  toc.section.depth=2
  chunk.section.depth=2
)

set(icl_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/icl.xml)
export_documentation(
  icl
  BOOSTBOOK
    ${icc_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${icldoc_bbk_xml}
)
