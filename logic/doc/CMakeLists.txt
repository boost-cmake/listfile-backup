# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)


set (LogicHeaders
  ../include/boost/logic/tribool.hpp
  ../include/boost/logic/tribool_fwd.hpp
  ../include/boost/logic/tribool_io.hpp
)

set(logic_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${LogicHeaders}
  OUTPUT
    ${logic_bbk_xml}
)

set (HtmlParameters
  boost.root=../../../..
)

export_documentation(
  logic
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/tribool.boostbook
    ${logic_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${logic_bbk_xml}
)
