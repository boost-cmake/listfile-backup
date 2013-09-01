# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)



set (AccumulatorsTagHeaders
    ../include/boost/accumulators/framework/depends_on.hpp
    ../include/boost/accumulators/framework/extractor.hpp
)

set(DoxygenTagParameters
  "MACRO_EXPANSION = YES"
  "EXPAND_ONLY_PREDEF = YES"
  "PREDEFINED = \"BOOST_ACCUMULATORS_DOXYGEN_INVOKED=1\" \\
    \"BOOST_PP_REPEAT_FROM_TO(a,b,c,d)=\" \\
    \"BOOST_PP_ENUM_PARAMS(a,b)=b ## 1, b ## 2, ...\""
)


set(doxy_tag ${CMAKE_CURRENT_BINARY_DIR}/accumulators.tag)
ryppl_doxygen(accumulators_tag
  TAG
  INPUT
    ${AccumulatorsTagHeaders}
  OUTPUT
    ${doxy_tag}
  PARAMETERS
    ${DoxygenTagParameters}
)



set(DoxygenParameters
  EXTRACT_ALL=YES
  HIDE_UNDOC_MEMBERS=NO
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  EXPAND_ONLY_PREDEF=YES
  SEARCH_INCLUDES=NO
  "PREDEFINED=\"BOOST_ACCUMULATORS_DOXYGEN_INVOKED=1\" \\
    \"BOOST_PP_REPEAT_FROM_TO(a,b,c,d)=\" \\
    \"BOOST_PP_REPEAT(a,b,c)=\" \\
    \"BOOST_PARAMETER_KEYWORD(a,b)=\\
      namespace a { struct b {}; } \\
      boost::parameter::keyword<a::b> const b;\" \\
    \"BOOST_PP_ENUM_PARAMS(a,b)=b ## 1, b ## 2, ...\""
)


file(GLOB AccDocHeaders
  "../include/boost/accumulators/accumulators*.hpp"
  "../include/boost/accumulators/framework/*.hpp"
  "../include/boost/accumulators/framework/parameters/*.hpp"
  "../include/boost/accumulators/framework/accumulators/*.hpp"
)

set(accdoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/accdoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${AccDocHeaders}
  OUTPUT
    ${accdoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Accumulators Framework Reference"
)



set(StatsDocHeaders
  "../include/boost/accumulators/statistics"
)

set(statsdoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/statsdoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${StatsDocHeaders}
  OUTPUT
    ${statsdoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.formuladir="images/accumulators/"
    boost.doxygen.reftitle="Statistics Library Reference"
)

file(GLOB OpDocHeaders
  "../include/boost/accumulators/numeric/functional.hpp"
  "../include/boost/accumulators/numeric/functional/*.hpp"
)


set(opdoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/opdoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${OpDocHeaders}
  OUTPUT
    ${opdoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Numeric Operators Library Reference"
)

set(acc_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/accumulators_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/accumulators.qbk
  ${acc_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)


# Generation of images (doxygen generates HTML, and also generates images with latex)
set(image_dir ${CMAKE_CURRENT_BINARY_DIR}/images/accumulators)


execute_process(
  COMMAND
    ${CMAKE_COMMAND} -E make_directory ${CMAKE_CURRENT_BINARY_DIR}/images
)

execute_process(
  COMMAND
    ${CMAKE_COMMAND} -E make_directory ${image_dir}
)


set(statsdoc_index ${image_dir}/index.html)
ryppl_doxygen(statsdoc_html
  HTML
  INPUT
    ${StatsDocHeaders}
  OUTPUT
    ${statsdoc_index}
  PARAMETERS
    GENERATE_HTML=YES
)

set(HtmlParameters
  boost.root=../../../..
  boost.max.id.length=1024
  toc.max.depth=4
  toc.section.depth=4
  chunk.section.depth=2
)

set(PdfParameters
  img.src.path=${CMAKE_CURRENT_BINARY_DIR}/
  boost.url.prefix=http://www.boost.org/doc/libs/release/doc/html
)

export_documentation(
  accumulators
  BOOSTBOOK
    ${acc_gen_xml}
  DEPENDS
    ${doxy_tag}
    ${accdoc_bbk_xml}
    ${statsdoc_bbk_xml}
    ${opdoc_bbk_xml}
    ${statsdoc_index}
  PATH
    ${CMAKE_CURRENT_BINARY_DIR}
  HTML_PARAMETERS
    ${HtmlParameters}
  PDF_PARAMETERS
    ${PdfParameters}
)

install(
  DIRECTORY
   ${image_dir}/
  DESTINATION
    share/doc/html/images/accumulators
  FILES_MATCHING PATTERN
    "*.png"

  PATTERN
   "search" EXCLUDE
)
