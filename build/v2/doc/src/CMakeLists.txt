# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

project(BoostBuildUserman)


include(Ryppl)
include(RypplDocumentation)

ryppl_find_and_use_package(Boostbook)

set(HtmlParameters
  toc.section.depth=1
  doc.standalone=true
  nav.layout=none
)

export_documentation(
  userman
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/userman.xml
  HTML_PARAMETERS
    ${HtmlParameters}
  PATH
    ${BOOST_BUILD_DOC_BINARY_DIR}
#  DEPENDS
#    BoostBuildDoc
)
