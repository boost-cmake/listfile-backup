# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


file (GLOB PoolHeaders
  ../include/boost/pool/*.hpp
)

set(DoxygenParameters
  WARNINGS=YES
  WARN_LOGFILE=AutoDoxywarnings.log
  RECURSIVE=NO
  EXTRACT_ALL=NO
  HIDE_UNDOC_MEMBERS=YES
  EXTRACT_PRIVATE=NO
  MACRO_EXPANSION=YES
  EXPAND_ONLY_PREDEF=YES
  "PREDEFINED=\"BOOST_PREVENT_MACRO_SUBSTITUTION=\" \"BOOST_STATIC_CONSTANT(t,v)=static const t v\" \"BOOST_DOXYGEN=1\""
)



set(autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${PoolHeaders}
  OUTPUT
    ${autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Boost.Pool C++ Reference"
)


set(pool_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/pool_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/pool.qbk
  ${pool_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
  DEFINES
    enable_index
)

set (HtmlParameters
  body.start.indent=0pt
  # Margin size:
  page.margin.inner=0.5in
  # Margin size:
  page.margin.outer=0.5in
  # Yes, we want graphics for admonishments:
  admon.graphics=1
  # Path for links to Boost:
  boost.root=../../../..

  # HTML options:
  # =============
  # Use graphics icons not text for navigation:
  navig.graphics=1
  # How far down we chunk nested sections, basically all of them:
  chunk.section.depth=2
  # Don't put the first section on the same page as the TOC itself:
  chunk.first.sections=1
  # How far down sections get TOC's
  toc.section.depth=4
  # Max depth in each TOC:
  toc.max.depth=2
  # How far down we go with TOC's
  generate.section.toc.level=10
  # Horizontal ? spacing in table cells.
  html.cellspacing=3 # pixels
  # Vertical spacing in table cells.
  html.cellpadding=5 # pixels
  boost.max.id.part.length=40
  # TODO set proper img path
  img.src.path=../images/
)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/index.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../
)


export_documentation(
  pool
  BOOSTBOOK
    ${pool_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
  DEPENDS
    ${autodoc_xml}
)
