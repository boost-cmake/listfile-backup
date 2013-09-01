# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

project(BoostMathDist)

set(math_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/math_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/math.qbk
  ${math_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
  DEFINES
    enable_index
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

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/index.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../../include/
)

export_documentation(
  sf_and_dist
  BOOSTBOOK
    ${math_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
)
