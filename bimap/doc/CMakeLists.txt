# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/bimap.qbk
  bimap_qbk.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set (HtmlParameters
  boost.root=../../../..
  html.stylesheet=boostbook.css
  toc.max.depth=2
  toc.section.depth=4
  chunk.section.depth=2
)

export_documentation(
  bimap
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/bimap_qbk.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
