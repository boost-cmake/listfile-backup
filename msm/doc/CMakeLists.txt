# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)

set(html_dir "${CMAKE_CURRENT_BINARY_DIR}/html")
set(manifest_file ${html_dir}/msm_HTML.manifest)

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
  msm
  DOCBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/src/msm.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
