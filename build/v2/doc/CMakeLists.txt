# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(BOOST_BUILD_DOC_BINARY_DIR ${CMAKE_CURRENT_BINARY_DIR})

add_subdirectory(src)

quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/bjam.qbk
  jam_docs_generated.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

export_documentation(
  jam_docs
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/jam_docs_generated.xml
)
