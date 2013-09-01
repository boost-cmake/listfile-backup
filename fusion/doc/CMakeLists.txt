# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(fusion_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/fusion_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/fusion.qbk
  ${fusion_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
  XINCLUDE_BASE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  chunk.section.depth=4
  chunk.first.sections=1
  toc.section.depth=3
  toc.max.depth=3
  generate.section.toc.level=4
)

export_documentation(
  fusion
  BOOSTBOOK
    ${fusion_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
