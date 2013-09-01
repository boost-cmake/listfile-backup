# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygenXmlToQuickbook)

# build geometry-specific tool for converting doxygen XML to quickbook
add_subdirectory(doxy)
add_subdirectory(src)


ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)
ryppl_find_and_use_package(DoxygenXmlToQuickbook)



add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/group__num__geometries.xml
  COMMAND ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/doxy/Doxyfile
  #DEPENDS ${DOXY_INPUT} ${DOXY_TAGFILES}
)

add_custom_target(
  CreateGeometryGeneratedDirectory
  COMMAND ${CMAKE_COMMAND} -E make_directory generated
  WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
  COMMENT "creating output directory for generated qbk files..."
)

set(CommonDoxygenXml2QbkParameters
  START_INCLUDE
    boost/geometry/
  CONVENIENCE_HEADER_PATH
    ../include/boost/geometry/
  CONVENIENCE_HEADERS
    geometry.hpp
    geometries/geometries.hpp
    multi/multi.hpp
  SKIP_NAMESPACE
    boost::geometry
  COPYRIGHT
    src/copyright_block.qbk
  DEPENDS
    CreateGeometryGeneratedDirectory
)

set(GeometryAlgoritms
  append assign make clear area buffer centroid convert correct covered_by
  convex_hull difference disjoint distance envelope equals expand for_each
  intersection intersects length num_geometries num_interior_rings num_points
  overlaps perimeter reverse simplify sym_difference touches transform union unique within
)


set(GeometryAccessFunctions
  get set exterior_ring interior_rings num_points num_interior_rings num_geometries
)


set(GeometryCoordinateSystems
  cartesian geographic polar spherical spherical_equatorial
)


set(GeometryCore
  closure coordinate_system coordinate_type cs_tag dimension
  # CMake forbids multiple outputs to one file
  #exception
  interior_type degree radian is_radian point_order point_type
  ring_type tag tag_cast
)

set(GeometryExceptions
  exception centroid_exception
)

set(GeometryIterators
  circular_iterator closing_iterator ever_circling_iterator
)

set(GeometryModels
  point linestring box polygon segment ring multi_linestring multi_point multi_polygon referring_segment
)


set(GeometryStrategies
  distance::pythagoras distance::haversine distance::cross_track distance::projected_point
  within::winding within::franklin within::crossings_multiply area::surveyor area::huiller
  centroid::bashein_detmer centroid::average convex_hull::graham_andrew
  simplify::douglas_peucker side::side_by_triangle side::side_by_cross_track side::spherical_side_formula
  transform::inverse_transformer transform::map_transformer transform::rotate_transformer transform::scale_transformer
  transform::translate_transformer transform::ublas_transformer
)

set(GeometryViews
  box_view segment_view closeable_view reversible_view identity_view
)

set(GeometryOtherGroups
  arithmetic register enum
)

foreach(item ${GeometryAlgoritms} ${GeometryAccessFunctions} ${GeometryOtherGroups})
  string(REPLACE "_" "__" doxy_name ${item})
  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${item}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/group__${doxy_name}.xml
    OUTPUT
      ${OUT_FILE}
    ${CommonDoxygenXml2QbkParameters}
    DEPENDS
      CreateGeometryGeneratedDirectory
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/group__num__geometries.xml
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endforeach()

foreach(item ${GeometryCoordinateSystems})
  string(REPLACE "_" "__" doxy_name ${item})
  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${item}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/structboost_1_1geometry_1_1cs_1_1${doxy_name}.xml
    OUTPUT
      ${OUT_FILE}
    ${CommonDoxygenXml2QbkParameters}
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endforeach()

foreach(item ${GeometryCore} ${GeometryIterators} ${GeometryViews})
  string(REPLACE "_" "__" doxy_name ${item})
  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${item}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/structboost_1_1geometry_1_1${doxy_name}.xml
    OUTPUT
      ${OUT_FILE}
      ${CommonDoxygenXml2QbkParameters}
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endforeach()

foreach(item ${GeometryExceptions})
  string(REPLACE "_" "__" doxy_name ${item})
  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${item}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/classboost_1_1geometry_1_1${doxy_name}.xml
    OUTPUT
      ${OUT_FILE}
    ${CommonDoxygenXml2QbkParameters}
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endforeach()

foreach(item ${GeometryModels})
  string(REPLACE "_" "__" doxy_name ${item})
  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${item}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/classboost_1_1geometry_1_1model_1_1${doxy_name}.xml
    OUTPUT
      ${OUT_FILE}
    ${CommonDoxygenXml2QbkParameters}
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endforeach()

foreach(item ${GeometryStrategies})
  string(FIND ${item} "::" ns_delimiter_pos)
  string(SUBSTRING ${item} 0 ${ns_delimiter_pos} ns)
  math(EXPR strategy_pos "${ns_delimiter_pos} + 2")
  string(SUBSTRING ${item} ${strategy_pos} -1 strategy)

  string(REPLACE "_" "__" ns_dox ${ns})
  string(REPLACE "_" "__" strategy_dox ${strategy})

  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${ns}_${strategy}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/classboost_1_1geometry_1_1strategy_1_1${ns_dox}_1_1${strategy_dox}.xml
    OUTPUT
      ${OUT_FILE}
    ${CommonDoxygenXml2QbkParameters}
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endforeach()




macro(model_to_quickbook2 classname section)

  set(OUT_FILE ${CMAKE_CURRENT_BINARY_DIR}/generated/${section}.qbk)
  doxyxml_to_quickbook(
    XML
      ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/classboost_1_1geometry_1_1model_1_1${classname}.xml
    OUTPUT
      ${OUT_FILE}
    ${CommonDoxygenXml2QbkParameters}
  )

  list(APPEND DOXY2QBK_DEPS_LIST ${OUT_FILE})
endmacro()




model_to_quickbook2(d2_1_1point__xy point_xy)



set(geometry_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/geometry_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/geometry.qbk
  ${geometry_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
  XINCLUDE_BASE
    ${CMAKE_CURRENT_SOURCE_DIR}
  DEFINES
    enable_index
  DEPENDS
    ${DOXY2QBK_DEPS_LIST}
    ${CMAKE_CURRENT_BINARY_DIR}/doxy/doxygen_output/xml/group__num__geometries.xml
)

set(HtmlParameters
  chunk.first.sections=1
  toc.section.depth=3
  toc.max.depth=2
  generate.section.toc.level=4
  boost.root=../../../..
)

export_documentation(
  geometry
  BOOSTBOOK
    ${geometry_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
