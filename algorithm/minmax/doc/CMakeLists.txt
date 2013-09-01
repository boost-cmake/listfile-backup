# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)

export_documentation(
  algo_minmax
  HTML
    ${CMAKE_CURRENT_SOURCE_DIR}/minmax_benchs.html
    ${CMAKE_CURRENT_SOURCE_DIR}/minmax_synopsis.html
)
