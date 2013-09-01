# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/context.qbk
  context_generated.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set (HtmlParameters
  # HTML options first:
  # How far down we chunk nested sections, basically all of them:
  chunk.section.depth=3
  # Don't put the first section on the same page as the TOC:
  chunk.first.sections=1
  # How far down sections get TOC's
  toc.section.depth=10
  # Max depth in each TOC:
  toc.max.depth=3
  # How far down we go with TOC's
  generate.section.toc.level=10
  # Path for links to Boost:
  boost.root=../../../..
)

export_documentation(
  context
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/context_generated.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
