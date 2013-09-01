# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(range_dbk_xml ${CMAKE_CURRENT_BINARY_DIR}/range_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/boost_range.qbk
  ${range_dbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    # TODO check includes
    #${CMAKE_CURRENT_SOURCE_DIR}/reference
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
  range
  BOOSTBOOK
    ${range_dbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
