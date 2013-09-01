# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${HeapHeaders}
  OUTPUT
    ${autodoc_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
)


file(GLOB UnitsReferenceHeaders ../include/boost/units/*.hpp)
list(APPEND UnitsReferenceHeaders ../include/boost/units/physical_dimensions.hpp)
set(units_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/units_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${UnitsReferenceHeaders}
  OUTPUT
    ${units_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Units Reference"
)


file(GLOB_RECURSE SiReferenceHeaders ../include/boost/units/systems/si/*.hpp)
list(APPEND SiReferenceHeaders ../include/boost/units/systems/si.hpp)
set(si_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/si_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${SiReferenceHeaders}
  OUTPUT
    ${si_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="SI System Reference"
)


file(GLOB_RECURSE CgsReferenceHeaders ../include/boost/units/systems/cgs/*.hpp)
list(APPEND CgsReferenceHeaders ../include/boost/units/systems/cgs.hpp)
set(cgs_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/cgs_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${CgsReferenceHeaders}
  OUTPUT
    ${cgs_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="CGS System Reference"
)




macro(make_base_units_doc prefix docName)
  file(GLOB_RECURSE ${prefix}ReferenceHeaders ../include/boost/base_units/${prefix}/*.hpp)
  set(${prefix}_base_units_doc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/${prefix}_base_units_reference.xml)
  ryppl_src_to_boostbook(
    INPUT
      ${CgsReferenceHeaders}
    OUTPUT
      ${${prefix}_base_units_doc_bbk_xml}
    DOXYFILE
      ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
    XSLT_PARAMETERS
      boost.doxygen.reftitle="${docName} Base Units Reference"
  )
endmacro()


make_base_units_doc(angle Angle)
make_base_units_doc(astronomical Astronomical)
make_base_units_doc(cgs CGS)
make_base_units_doc(imperial Imperial)
make_base_units_doc(metric Metric)
make_base_units_doc(si SI)
make_base_units_doc(temperature Temperature)
make_base_units_doc(us US)





file(GLOB_RECURSE PhysicalDimensionsReferenceHeaders ../include/boost/units/physical_dimensions/*.hpp)
list(APPEND PhysicalDimensionsReferenceHeaders ../include/boost/units/systems/cgs.hpp)
set(physical_dimensions_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/dimensions_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${PhysicalDimensionsReferenceHeaders}
  OUTPUT
    ${physical_dimensions_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Dimensions Reference"
)


file(GLOB_RECURSE TrigReferenceHeaders ../include/boost/units/systems/angle/*.hpp)
#list(APPEND TrigReferenceHeaders ../include/boost/units/systems/trig.hpp)
set(trig_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/trig_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${TrigReferenceHeaders}
  OUTPUT
    ${trig_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Trigonometry and Angle System Reference"
)



file(GLOB_RECURSE TemperatureReferenceHeaders ../include/boost/units/systems/temperature/*.hpp)
set(temperature_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/temperature_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${TemperatureReferenceHeaders}
  OUTPUT
    ${temperature_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Temperature System Reference"
)


set(AbstractReferenceHeaders
  ../include/boost/units/systems/abstract.hpp
)
set(abstract_reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/abstract_reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${AbstractReferenceHeaders}
  OUTPUT
    ${abstract_reference_bbk_xml}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/units.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Temperature System Reference"
)


set(base_units_qbk_file ${CMAKE_CURRENT_BINARY_DIR}/base_units.qbk)
# TODO Remove conversions.hpp
function(gen_units_base_qbk)
  foreach(fileName ${ARGV})
    get_filename_component(base ${fileName} NAME)
    list(FIND known ${base} pos)
    if (pos GREATER -1)
      list(APPEND duplicates ${base})
    else()
      list(APPEND known ${base})
    endif()
    # dirty hack for sorting list by basename (add basename to the beginning of item)
    list(APPEND sorted_file_list "${base}^${fileName}")
  endforeach()
  list(REMOVE_DUPLICATES known)
  list(REMOVE_DUPLICATES duplicates)

  list(SORT sorted_file_list)

  file(WRITE ${base_units_qbk_file}
    "# This file is automatically generated with CMake\n"
    "# All changes will be overwritten\n\n"
  )

  foreach(fileName_and_full_path ${sorted_file_list})
    # regex explanation: http://stackoverflow.com/questions/7793950/regex-to-remove-all-text-before-a-character
    string(REGEX REPLACE "^[^\\^]*\\^(.*)" "\\1" fileName "${fileName_and_full_path}")
    file(RELATIVE_PATH output_filename ${CMAKE_CURRENT_SOURCE_DIR}/../include ${fileName})
    get_filename_component(base_filename ${output_filename} NAME)
    get_filename_component(base_unit ${output_filename} NAME_WE)
    list(FIND duplicates ${base_filename} pos)
    if (pos GREATER -1)
      get_filename_component(file_path ${fileName} PATH)
      get_filename_component(dir_name ${file_path} NAME)
      set(base_unit "${base_unit} ${dir_name}")
    endif()
    file(APPEND ${base_units_qbk_file} "[headerref ${output_filename} ${base_unit}][br]\n")
  endforeach()
endfunction()



file(GLOB_RECURSE BaseUnitsHeaders ../include/boost/units/base_units/*.hpp)
gen_units_base_qbk(${BaseUnitsHeaders})



set(units_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/units_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/units.qbk
  ${units_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  DEPENDS
    ${units_reference_bbk_xml}
    ${si_reference_bbk_xml}
    ${cgs_reference_bbk_xml}

    ${angle_base_units_doc_bbk_xml}
    ${astronomical_base_units_doc_bbk_xml}
    ${cgs_base_units_doc_bbk_xml}
    ${imperial_base_units_doc_bbk_xml}
    ${metric_base_units_doc_bbk_xml}
    ${si_base_units_doc_bbk_xml}
    ${temperature_base_units_doc_bbk_xml}
    ${us_base_units_doc_bbk_xml}

    ${physical_dimensions_reference_bbk_xml}
    ${trig_reference_bbk_xml}
    ${temperature_reference_bbk_xml}
    ${abstract_reference_bbk_xml}

    ${base_units_qbk_file}
)









set(HtmlParameters
  toc.max.depth=1
  toc.section.depth=8
  chunk.section.depth=8
  boost.root="../../../.."
)

export_documentation(
  units
  BOOSTBOOK
    ${units_gen_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
