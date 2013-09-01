# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)

file (GLOB ProgramOptionsHeaders
  ../include/boost/program_options/*.hpp
)

set(autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${ProgramOptionsHeaders}
  OUTPUT
    ${autodoc_xml}
)

export_documentation(
  program_options
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/program_options.xml
  DEPENDS
    ${autodoc_xml}
)
