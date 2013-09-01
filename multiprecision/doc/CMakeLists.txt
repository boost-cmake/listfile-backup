# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)
ryppl_find_and_use_package(BoostAutoIndex)

set(multiprecision_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/multiprecision_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/multiprecision.qbk
  ${multiprecision_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
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
  #<xsl:param>html.stylesheet=../../../../doc/src/boostbook.css

  # HTML options first:
  # Use graphics not text for navigation:
  navig.graphics=1
  # How far down we chunk nested sections, basically all of them:
  chunk.section.depth=10
  # Don't put the first section on the same page as the TOC:
  chunk.first.sections=10
  # How far down sections get TOC's
  toc.section.depth=10
  # Max depth in each TOC:
  toc.max.depth=4
  # How far down we go with TOC's
  #<xsl:param>generate.section.toc.level=10
  # Index on type:
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
  multiprecision
  BOOSTBOOK
    ${multiprecision_gen_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
)
