# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



set(phoenix_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/phoenix_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/phoenix3.qbk
  ${phoenix_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set (HtmlParameters
  boost.root=../../../..
  chunk.section.depth=3
  chunk.first.sections=1
  toc.section.depth=3
  toc.max.depth=3
  generate.section.toc.level=3
)

export_documentation(
  phoenix
  BOOSTBOOK
    ${phoenix_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
