# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)

set (StringAlgoHeaders
  ../../include/boost/algorithm/string.hpp
  ../../include/boost/algorithm/string_regex.hpp
  ../../include/boost/algorithm/string
)

set(doxy_xml ${CMAKE_CURRENT_BINARY_DIR}/string_algo_doxy.xml)
ryppl_doxygen(string_algo_doxy
  XML
  INPUT
    ${StringAlgoHeaders}
  OUTPUT
    ${doxy_xml}
)

# convert from doxygen XML to to boostbook XML
xslt_doxy_to_boostbook(
  INPUT
    ${doxy_xml}
  OUTPUT
    ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml
)


set(HtmlParameters
  boost.root=../../../..
  chapter.autolabel=0
  chunk.section.depth=8
  toc.section.depth=2
  toc.max.depth=2
  generate.section.toc.level=1
)

export_documentation(
  string_algo
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/string_algo.xml
  DEPENDS
    ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
