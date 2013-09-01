# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/function_types.qbk
  function_types_generated.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
  XINCLUDE_BASE
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  chunk.first.sections=1
  chunk.section.depth=2
  generate.section.toc.level=2
  toc.section.depth=1
  toc.max.depth=1
)

export_documentation(
  function_types
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/function_types_generated.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
