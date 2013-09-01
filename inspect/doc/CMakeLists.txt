# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



set(inspect_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/inspect_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/inspect.qbk
  ${inspect_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)

set (HtmlParameters
  boost.root=../../../..
)

export_documentation(
  inspect
  BOOSTBOOK
    ${inspect_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
