# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


file (GLOB PropertyTreeHeaders
  ../include/boost/../../../boost/property_tree/*.hpp
)

set(DoxygenParameters
  EXTRACT_ALL=YES
  "PREDEFINED=\"BOOST_PROPERTY_TREE_DOXYGEN_INVOKED\" \\
              \"BOOST_DEDUCED_TYPENAME=typename\""
  HIDE_UNDOC_MEMBERS=NO
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  EXPAND_ONLY_PREDEF=YES
  SEARCH_INCLUDES=YES
  INCLUDE_PATH=../../../
  EXAMPLE_PATH=../examples
  BRIEF_MEMBER_DESC=YES
  REPEAT_BRIEF=YES
  ALWAYS_DETAILED_SEC=YES
  MULTILINE_CPP_IS_BRIEF=YES
)



set(autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${PropertyTreeHeaders}
  OUTPUT
    ${autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)


set(property_tree_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/property_tree_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/property_tree.qbk
  ${property_tree_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  toc.max.depth=3
  toc.section.depth=2
  chunk.section.depth=3
)

export_documentation(
  property_tree
  BOOSTBOOK
    ${property_tree_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${autodoc_xml}
)
