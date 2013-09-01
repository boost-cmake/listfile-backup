# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(unordered_dbk_xml ${CMAKE_CURRENT_BINARY_DIR}/unordered_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/unordered.qbk
  ${unordered_dbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  chunk.first.sections=1
  chunk.section.depth=2
  generate.section.toc.level=2
  toc.section.depth=1
  toc.max.depth=1

  boost.compact.typedef=0
  boost.compact.function=0
  boost.compact.enum=0

  # HTML Options:
  boost.root=../../../..
  img.src.path=../../../../doc/html/
)

export_documentation(
  unordered
  BOOSTBOOK
    ${unordered_dbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
