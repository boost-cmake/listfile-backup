# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(BoostAutoIndex
  DEPENDS
    BoostArray
    BoostFilesystem
    BoostProgramOptions
)

ryppl_add_test_subdirectory(test)
ryppl_add_doc_subdirectory(doc)

add_executable(auto_index
  src/auto_index.cpp
  src/file_scanning.cpp
  src/index_generator.cpp
  src/tiny_xml.cpp
)

target_link_libraries(auto_index
  boost_program_options
  boost_filesystem
  boost_system
  boost_regex
)


configure_file(include/auto_index_helpers.qbk include/auto_index_helpers.qbk)

ryppl_export(
  TARGETS
    auto_index
  CODE
    "set(BOOST_AUTOINDEX_QBK_DIR \"\${CMAKE_CURRENT_LIST_DIR}/../auto_index/include\")\n"
)
