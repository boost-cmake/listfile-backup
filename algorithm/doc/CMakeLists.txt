# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



set (AlgoHeaders
  ../include/boost/algorithm/clamp.hpp
  ../include/boost/algorithm/hex.hpp
  ../include/boost/algorithm/minmax_element.hpp
  ../include/boost/algorithm/minmax.hpp

  ../include/boost/algorithm/searching/boyer_moore_horspool.hpp
  ../include/boost/algorithm/searching/boyer_moore.hpp
  ../include/boost/algorithm/searching/knuth_morris_pratt.hpp
)


set(autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${AlgoHeaders}
  OUTPUT
    ${autodoc_bbk_xml}
  DOXYGEN_PARAMETERS
    "PREDEFINED=\"BOOST_ALGORITHM_DOXYGEN=1\""
    WARNINGS=YES
)

set(algo_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/algo_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/algorithm.qbk
  ${algo_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
  XINCLUDE_BASE
    ${CMAKE_CURRENT_SOURCE_DIR}
)


set(HtmlParameters
  boost.root=../../../..
  boost.doxygen.reftitle="Boost.Algorithms C++ Reference"
  chapter.autolabel=0
  chunk.section.depth=8
  toc.section.depth=2
  toc.max.depth=2
  generate.section.toc.level=1
)

export_documentation(
  algorithm
  BOOSTBOOK
    ${algo_bbk_gen_xml}
  DEPENDS
    ${autodoc_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
