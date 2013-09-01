# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/config.qbk
  config_qbk.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)


set (HtmlParameters
  toc.max.depth=2
  toc.section.depth=2
  chunk.section.depth=1
  boost.root=../../../..
)

export_documentation(
  config
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/config_qbk.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
