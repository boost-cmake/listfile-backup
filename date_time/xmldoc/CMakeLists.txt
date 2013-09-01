# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)

file(GLOB date_time_files ../include/boost/date_time/*.hpp)
file(GLOB gregorian_files ../include/boost/date_time/gregorian/*.hpp)
file(GLOB posix_time_files ../include/boost/date_time/posix_time/*.hpp)
file(GLOB local_time_files ../include/boost/date_time/local_time/*.hpp)

list(REMOVE_ITEM gregorian_files ../include/boost/date_time/gregorian/event_schedule.hpp)


set(DoxygenParameters
  ENABLE_PREPROCESSING=NO
)

# Date time reference
set(date_time_autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/date_time_autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${date_time_files}
  OUTPUT
    ${date_time_autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.refid=date_time_reference
    boost.doxygen.reftitle="Date Time Reference"
)

# Gregorian reference
set(gregorian_autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/gregorian_autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${gregorian_files}
  OUTPUT
    ${gregorian_autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.refid=gregorian_reference
    boost.doxygen.reftitle="Gregorian Reference"
)


# Posix time reference
set(posix_time_autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/posix_time_autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${posix_time_files}
  OUTPUT
    ${posix_time_autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.refid=posix_time_reference
    boost.doxygen.reftitle="Posix Time Reference"
)


# Local time reference
set(local_time_autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/local_time_autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${local_time_files}
  OUTPUT
    ${local_time_autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.refid=local_time_reference
    boost.doxygen.reftitle="Local Time Reference"
)

export_documentation(
  date_time
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/date_time.xml
  DEPENDS
    ${date_time_autodoc_xml}
    ${gregorian_autodoc_xml}
    ${posix_time_autodoc_xml}
    ${local_time_autodoc_xml}
)
