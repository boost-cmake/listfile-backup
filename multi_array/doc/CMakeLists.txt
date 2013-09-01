# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)

set (HtmlParameters
  # Path for links to Boost:
  boost.root=../../../..

  # Some general style settings:
  table.footnote.number.format=1
  footnote.number.format=1

  # HTML options first:
  # Use graphics not text for navigation:
  #navig.graphics=1
  # How far down we chunk nested sections, basically all of them:
  chunk.section.depth=0
  # Don't put the first section on the same page as the TOC:
  #chunk.first.sections=0
  # How far down sections get TOC's
  toc.section.depth=2
  # set output name
  root.filename=reference
)

export_documentation(
  multi_array
  DOCBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/xml/reference.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
