# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(spirit2_dbk_xml ${CMAKE_CURRENT_BINARY_DIR}/spirit2_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/spirit2.qbk
  ${spirit2_dbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
  DEFINES
    __use_auto_index__
)

set(HtmlParameters
  boost.root=../../../..
  chunk.section.depth=4
  chunk.first.sections=1
  toc.section.depth=3
  toc.max.depth=3
  generate.section.toc.level=4
  admon.graphics.path=images/
  index.on.type=1
)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/index.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/
)

export_documentation(
  spirit
  BOOSTBOOK
    ${spirit2_dbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
)
