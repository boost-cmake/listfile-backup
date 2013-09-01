# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)

ryppl_find_and_use_package(Boostbook)

set (HtmlParameters
  boost.root=../../../..
)

export_documentation(
  ref
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/ref.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)
