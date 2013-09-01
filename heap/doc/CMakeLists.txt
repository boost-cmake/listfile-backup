# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



file(GLOB HeapHeaders ../include/boost/heap/*.hpp)

list(APPEND HeapHeaders ../include/boost/heap/detail/mutable_heap.hpp)


set(DoxygenParameters
  "PREDEFINED=\"BOOST_DOXYGEN_INVOKED\" \\
     \"BOOST_DEDUCED_TYPENAME=typename\" \\
     \"BOOST_HAS_RVALUE_REFS\" \\"
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_CLASSES=YES
  INLINE_INHERITED_MEMB=YES
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  EXPAND_ONLY_PREDEF=YES
  SEARCH_INCLUDES=YES
  INCLUDE_PATH=../../..
  EXAMPLE_PATH=${CMAKE_CURRENT_SOURCE_DIR}/../examples
  BRIEF_MEMBER_DESC=YES
  REPEAT_BRIEF=YES
  ALWAYS_DETAILED_SEC=YES
  MULTILINE_CPP_IS_BRIEF=YES
)

set(autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${HeapHeaders}
  OUTPUT
    ${autodoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)

set(heap_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/heap_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/heap.qbk
  ${heap_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)

set(HtmlParameters
  html.stylesheet=boostbook.css
  boost.root=../../../..
  boost.libraries=../../../libraries.htm
  toc.max.depth=3
  toc.section.depth=1
  chunk.section.depth=1
)

export_documentation(
  heap
  BOOSTBOOK
    ${heap_gen_bbk_xml}
  DEPENDS
    ${autodoc_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
