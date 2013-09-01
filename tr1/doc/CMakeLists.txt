# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(tr1_dbk_xml ${CMAKE_CURRENT_BINARY_DIR}/tr1_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/tr1.qbk
  ${tr1_dbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  # HTML options first:
  # Use graphics not text for navigation:
  navig.graphics=1
  # How far down we chunk nested sections, basically all of them:
  chunk.section.depth=10
  # Don't put the first section on the same page as the TOC:
  chunk.first.sections=1
  # How far down sections get TOC's
  toc.section.depth=10
  # Max depth in each TOC:
  toc.max.depth=4
  # How far down we go with TOC's
  generate.section.toc.level=10
  # Path for links to Boost:
  boost.root=../../../..
)

export_documentation(
  tr1
  BOOSTBOOK
    ${tr1_dbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
