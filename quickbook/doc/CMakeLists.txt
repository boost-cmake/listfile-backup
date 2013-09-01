# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(quickbook_dbk_xml ${CMAKE_CURRENT_BINARY_DIR}/quickbook_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/quickbook.qbk
  ${quickbook_dbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)


export_documentation(
  quickbook
  BOOSTBOOK
    ${quickbook_dbk_xml}
)
