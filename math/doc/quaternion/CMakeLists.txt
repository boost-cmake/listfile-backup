# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

project(BoostMathQuaternion)

set(quaternion_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/quaternion_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/math-quaternion.qbk
  ${quaternion_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)

set (HtmlParameters
  # Path for links to Boost:
  boost.root=../../../..

  # Some general style settings:
  table.footnote.number.format=1
  footnote.number.format=1

  # HTML options first:
  # Use graphics not text for navigation:
  navig.graphics=1
  # How far down we chunk nested sections, basically all of them:
  chunk.section.depth=1
  # Don't put the first section on the same page as the TOC:
  chunk.first.sections=0
  # How far down sections get TOC's
  toc.section.depth=1
)

export_documentation(
  quaternion
  BOOSTBOOK
    ${quaternion_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
