# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


file (GLOB XpressiveHeaders
  ../include/boost/xpressive/*.hpp
  ../include/boost/xpressive/traits/*.hpp
)

set(DoxygenParameters
  EXTRACT_ALL=YES
  "PREDEFINED=\"BOOST_XPRESSIVE_DOXYGEN_INVOKED\" \\
    \"BOOST_DEDUCED_TYPENAME=typename\" \\
    \"BOOST_XPRESSIVE_GLOBAL_MARK_TAG(x,y)=mark_tag const x(y)\" \\
    \"BOOST_STATIC_CONSTANT(x,y)=static x const y\" \\
    \"BOOST_XPR_NONDEDUCED_TYPE_(X)=X\" \\
    \"UNREF(X)=typename remove_reference<X>::type\" \\
    \"UNCV(X)=typename remove_const<X>::type\" \\
    \"UNCVREF(X)=typename remove_const<typename remove_reference<X>::type>::type\""
  HIDE_UNDOC_MEMBERS=NO
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  EXPAND_ONLY_PREDEF=YES
  SEARCH_INCLUDES=YES
  #INCLUDE_PATH=$(BOOST_ROOT)
)



set(autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${XpressiveHeaders}
  OUTPUT
    ${autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)


set(xpressive_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/xpressive_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/xpressive.qbk
  ${xpressive_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  toc.max.depth=3
  toc.section.depth=3
  chunk.section.depth=3
)

export_documentation(
  xpressive
  BOOSTBOOK
    ${xpressive_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${autodoc_xml}
)
