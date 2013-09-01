# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(auto_index_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/auto_index_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/auto_index.qbk
  ${auto_index_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)


set(indexed_bbk_file ${CMAKE_CURRENT_BINARY_DIR}/auto_index_indexed.xml)
generate_index(
  INPUT
    ${auto_index_bbk_xml}
  OUTPUT
    ${indexed_bbk_file}

)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/autoindex.idx
)

set (HtmlParameters
  # TODO Adjust boost.root
  boost.root=../../../..
  # Path for libraries index:
  boost.libraries=${boost_root}/libs/libraries.htm

  # Some general style settings:
  table.footnote.number.format=1
  footnote.number.format=1

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
  # Index on type:
  index.on.type=1
)

export_documentation(
  auto_index
  BOOSTBOOK
    ${indexed_bbk_file}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
)
