# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


set (ContainerHeaders
  ../include/boost/container
)

set(DoxygenParameters
  EXTRACT_ALL=NO
  HIDE_UNDOC_MEMBERS=YES
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  EXPAND_ONLY_PREDEF=YES
  MACRO_EXPANSION=YES
  "PREDEFINED=\"insert_const_ref_type= const T&\" \\
    \"BOOST_CONTAINER_DOXYGEN_INVOKED\" \\
    \"BOOST_CONTAINER_IMPDEF(T)=implementation_defined\" \\
    \"BOOST_CONTAINER_SEEDOC(T)=see_documentation\" \\
    \"BOOST_CONTAINER_NOEXCEPT=noexcept\" \\
    \"BOOST_CONTAINER_NOEXCEPT_IF(T)=noexcept(T)\" \\
    \"BOOST_RV_REF(T)=T &&\" \\
    \"BOOST_RV_REF_BEG=\" \\
    \"BOOST_RV_REF_END=&&\" \\
    \"BOOST_COPY_ASSIGN_REF(T)=const T &\" \\
    \"BOOST_FWD_REF(a)=a &&\""
)



set(autodoc_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${ContainerHeaders}
  OUTPUT
    ${autodoc_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Boost.Container Header Reference"
)


set(container_bbk_generated_xml ${CMAKE_CURRENT_BINARY_DIR}/container_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/container.qbk
  ${container_bbk_generated_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/index.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/
)

set(HtmlParameters
  boost.root=../../../..
  boost.libraries=../../../../libs/libraries.htm
  generate.section.toc.level=3
  chunk.first.sections=1
)

export_documentation(
  container
  BOOSTBOOK
    ${container_bbk_generated_xml}
  DEPENDS
    ${autodoc_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
)
