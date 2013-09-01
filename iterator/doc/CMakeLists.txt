# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


set(iterator_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/iterator_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/quickbook/iterator.qbk
  ${iterator_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_SOURCE_DIR}/quickbook
)

set (HtmlParameters
  boost.root=../../../..
  toc.max.depth=3
  toc.section.depth=3
  chunk.section.depth=4
)

export_documentation(
  iterator
  BOOSTBOOK
    ${iterator_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
