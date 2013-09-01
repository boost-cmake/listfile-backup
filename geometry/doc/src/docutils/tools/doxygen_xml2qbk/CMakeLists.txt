# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt


include(Ryppl)

ryppl_project(DoxygenXmlToQuickbook
  DEPENDS
    BoostProgramOptions
    BoostPropertyTree # for RapidXML
)

if (${RYPPL_DoxygenXmlToQuickbook_VALID})

  # dirty hack for searching rapidXML directory from property_tree include dirs
  foreach(includeDir ${BoostPropertyTree_INCLUDE_DIRS})
    # NOTE there are also some nonexistent dirs, assume compiler silenly ignores it
    include_directories(${includeDir}/boost/property_tree/detail)
  endforeach()

  include_directories(${CMAKE_CURRENT_SOURCE_DIR})

  add_executable(doxygen_xml2qbk
    doxygen_xml2qbk.cpp
  )

  target_link_libraries(doxygen_xml2qbk
    boost_program_options
  )
endif()

ryppl_export(TARGETS doxygen_xml2qbk)
