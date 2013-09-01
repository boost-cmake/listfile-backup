# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)

export_documentation(
  assign
  HTML
    ${CMAKE_CURRENT_SOURCE_DIR}/style.css
    ${CMAKE_CURRENT_SOURCE_DIR}/email_example.html
    ${CMAKE_CURRENT_SOURCE_DIR}/index.html
    ${CMAKE_CURRENT_SOURCE_DIR}/multi_index_container.html
    ${CMAKE_CURRENT_SOURCE_DIR}/my_vector_example.html
)
