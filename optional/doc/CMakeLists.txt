# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



set(optional_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/optional_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/optional.qbk
  ${optional_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
)

set (HtmlParameters
  boost.root=../../../..
  html.stylesheet=boostbook.css
  toc.max.depth=2
  toc.section.depth=2
  chunk.section.depth=1
)

export_documentation(
  optional
  BOOSTBOOK
    ${optional_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
