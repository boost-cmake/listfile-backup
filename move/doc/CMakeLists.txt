# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


set(MoveHeaders
  "../include/boost/move/"
)

set(DoxygenParameters
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_CLASSES=YES
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  "PREDEFINED=\"BOOST_MOVE_DOXYGEN_INVOKED\""
)



set(autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${MoveHeaders}
  OUTPUT
    ${autodoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)

set(move_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/move_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/move.qbk
  ${move_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  boost.libraries=../../../../libs/libraries.htm
  generate.section.toc.level=3
  chunk.first.sections=1
)

export_documentation(
  move
  BOOSTBOOK
    ${move_gen_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${autodoc_bbk_xml}
)
