# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostInspect
  DEPENDS
    BoostAlgorithm
    BoostConfig
    BoostConversion
    BoostFilesystem
    BoostSystem
    BoostRegex
    BoostSmartPtr
    BoostTest
    BoostUtility
)

ryppl_add_doc_subdirectory(doc)

if (${RYPPL_BoostInspect_VALID})

add_executable(inspect
  apple_macro_check.cpp
  ascii_check.cpp
  assert_macro_check.cpp
  copyright_check.cpp
  crlf_check.cpp
  deprecated_macro_check.cpp
  end_check.cpp
  inspect.cpp
  license_check.cpp
  link_check.cpp
  minmax_check.cpp
  path_name_check.cpp
  tab_check.cpp
  unnamed_namespace_check.cpp
  )

target_link_libraries(inspect
  boost_filesystem
  boost_system
  boost_regex
)

endif()

ryppl_export(TARGETS inspect)
