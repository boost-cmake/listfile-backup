# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(static_assert_dbk_xml ${CMAKE_CURRENT_BINARY_DIR}/static_assert_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/static_assert.qbk
  ${static_assert_dbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  nav.layout=none
  navig.graphics=0
)

export_documentation(
  static_assert
  BOOSTBOOK
    ${static_assert_dbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
