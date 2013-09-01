# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(lexical_cast_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/lexical_cast_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/lexical_cast.qbk
  ${lexical_cast_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

export_documentation(
  lexical_cast
  BOOSTBOOK
    ${lexical_cast_bbk_xml}
)
