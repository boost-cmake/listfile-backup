# Adds documentation for the current library or tool project
#
#   ryppl_documentation(<docbook-file>)

#=============================================================================
# Copyright (C) 2008 Douglas Gregor <doug.gregor@gmail.com>
# Copyright (C) 2011-2012 Daniel Pfeifer <daniel@pfeifer-mail.de>
# Copyright (C) 2013 Alexey Kutumov <alexey.kutumov@gmail.com>
#
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt
#=============================================================================


include(RypplDoxygen)
include(RypplXsltproc)




# This function performs transformation boostbook xml
# to docbook xml using docbook.xsl
#
# input parameters:
#  INPUT <input_file> - original file (boostbook XML)
#  OUTPUT <output_file> - resulting file (docbook XML)
#  DEPENDS <file_list> - list of files, which must trigger this conversion
#   can be empty. Usually this parameters is used when input xml contains
#   include directive with generated files.
#  PATH <path_list> - list of paths where search files for inclusion
#  PARAMETERS <param_list> - list of parameters which passed directly to xsltproc
#
# Example:
# xslt_boostbook_to_docbook(
#   INPUT
#     ${CMAKE_CURRENT_BINARY_DIR}/algorithm.xml
#   OUTPUT
#     ${dbk_file}
#   DEPENDS
#     ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml
#   PATH
#     ${CMAKE_CURRENT_SOURCE_DIR}
#     ${CMAKE_CURRENT_BINARY_DIR}
# )
#
function(xslt_boostbook_to_docbook)
  cmake_parse_arguments(XSL
    ""
    "OUTPUT"
    "DEPENDS;INPUT;PARAMETERS;PATH"
    ${ARGN}
  )

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${XSL_OUTPUT})

  xsltproc(
    INPUT
      ${XSL_INPUT}
    OUTPUT
      ${XSL_OUTPUT}
    CATALOG
      ${BOOSTBOOK_CATALOG}
    STYLESHEET
      ${BOOSTBOOK_XSL_DIR}/docbook.xsl
    DEPENDS
      ${XSL_DEPENDS}
    PATH
      ${XSL_PATH}
    PARAMETERS
      ${XSL_PARAMETERS}
    COMMENT
      "converting boostbook XML to docbook XML: ${rel_output} ..."
  )
endfunction()


# Function performs conversion from docbook xml to html
#
# See `xslt_boostbook_to_docbook` description 
#   for parameters INPUT, OUTPUT, DEPENDS, PARAMETERS, PATH 
# MANIFEST <manifest_file> - file which contains list of files after generation
#  this file can be passed as parameter to function `add_to_doc`
function(xslt_docbook_to_html)
  cmake_parse_arguments(XSL
    ""
    "OUTPUT;MANIFEST"
    "DEPENDS;INPUT;PARAMETERS;PATH"
    ${ARGN}
  )

  if(NOT XSL_MANIFEST)
    message(FATAL_ERROR "xslt_docbook_to_html command requires MANIFEST parameter!")
  endif()

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${XSL_MANIFEST})

  xsltproc(
    INPUT
      ${XSL_INPUT}
    OUTPUT
      ${XSL_MANIFEST}
    CATALOG
      ${BOOSTBOOK_CATALOG}
    STYLESHEET
      ${BOOSTBOOK_XSL_DIR}/html.xsl
    DEPENDS
      ${XSL_DEPENDS}
    PATH
      ${XSL_PATH}
    PARAMETERS
      ${XSL_PARAMETERS}
      manifest="${XSL_MANIFEST}"
    COMMENT
      "converting docbook XML to HTML: ${rel_output} ..."
  )
endfunction()





# Function performs conversion from docbook xml to single html
#
# See `xslt_boostbook_to_docbook` description
#   for parameters INPUT, OUTPUT, DEPENDS, PARAMETERS, PATH
function(xslt_docbook_to_single_html)
  cmake_parse_arguments(XSL
    ""
    ""
    "DEPENDS;INPUT;OUTPUT;PARAMETERS;PATH"
    ${ARGN}
  )

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${XSL_OUTPUT})

  xsltproc(
    INPUT
      ${XSL_INPUT}
    OUTPUT
      ${XSL_OUTPUT}
    CATALOG
      ${BOOSTBOOK_CATALOG}
    STYLESHEET
      ${BOOSTBOOK_XSL_DIR}/html-single.xsl
    DEPENDS
      ${XSL_DEPENDS}
    PATH
      ${XSL_PATH}
    PARAMETERS
      ${XSL_PARAMETERS}
      #manifest="${XSL_MANIFEST}"
    COMMENT
      "converting docbook XML to single HTML: ${rel_output} ..."
  )
endfunction()




# Function performs conversion from docbook xml to html
#
# See `xslt_boostbook_to_docbook` description 
#   for parameters INPUT, OUTPUT, DEPENDS, PARAMETERS, PATH 
function(xslt_doxy_to_boostbook)
  cmake_parse_arguments(XSL
    ""
    "OUTPUT"
    "DEPENDS;INPUT;PARAMETERS;PATH"
    ${ARGN}
  )

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${XSL_OUTPUT})

  xsltproc(
    INPUT
      ${XSL_INPUT}
    OUTPUT
      ${XSL_OUTPUT}
    CATALOG
      ${BOOSTBOOK_CATALOG}
    STYLESHEET
      ${BOOSTBOOK_XSL_DIR}/doxygen/doxygen2boostbook.xsl
    DEPENDS
      ${XSL_DEPENDS}
    PATH
      ${XSL_PATH}
    PARAMETERS
      ${XSL_PARAMETERS}
    COMMENT
      "converting doxygen XML to boostbook XML: ${rel_output} ..."
  )
endfunction()


# Function converts sources to boostbook XML in the following way:
#  src -> doxygen XML -> boostbook XML
#
# This function acts as simple composition of two commands
#  ryppl_doxygen and xslt_doxy_to_boostbook
# Parameters:
#  INPUT <input_file_list_or_path> - list of files and/or directories
#   which contain source code with doxygen comments
#  OUTPUT <file> - filename for generated boostbook XML
#  DOXYFILE <file> - file with doxygen parameters (optional)
#  DOXYGEN_PARAMETERS <param_list> - list of doxygen parameters
#   which pass directly to doxygen (params seta as <key>=<value>)
#  XSLT_PATH <list> - passed directly to xsltproc,
#   see also documentation for `xslt_boostbook_to_docbook`
#  XSLT_PARAMETERS <param_list> - passed directly to xsltproc
#   see also documentation for `xslt_boostbook_to_docbook`
#
# Usage example
function (ryppl_src_to_boostbook)
  cmake_parse_arguments(DOXY_BBK
    ""
    "OUTPUT;DOXYFILE"
    "DEPENDS;INPUT;DOXYGEN_PARAMETERS;XSLT_PATH;XSLT_PARAMETERS"
    ${ARGN}
  )

  get_filename_component(doxy_name ${DOXY_BBK_OUTPUT} NAME_WE)

  set(doxy_output ${DOXY_BBK_OUTPUT}.doxyxml)
  ryppl_doxygen(
    ${PROJECT_NAME}_${doxy_name}_doxy
    XML
    INPUT
      ${DOXY_BBK_INPUT}
    OUTPUT
      ${doxy_output}
    DOXYFILE
      ${DOXY_BBK_DOXYFILE}
    PARAMETERS
      ${DOXY_BBK_DOXYGEN_PARAMETERS}
  )

  xslt_doxy_to_boostbook(
    INPUT
      ${doxy_output}
    OUTPUT
      ${DOXY_BBK_OUTPUT}
    PATH
      ${DOXY_BBK_XSLT_PATH}
    PARAMETERS
      ${DOXY_BBK_XSLT_PARAMETERS}
  )
endfunction()



# This functions performs merging of several boostbooks into one
function(merge_boostbook)
  cmake_parse_arguments(merge_dbk
    ""
    "INPUT;OUTPUT"
    "PATH;DEPENDS"
    ${ARGN}

  )

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${merge_dbk_OUTPUT})

  xsltproc(
    INPUT
      ${merge_dbk_INPUT}
    OUTPUT
      ${merge_dbk_OUTPUT}
    STYLESHEET
      ${BOOSTBOOK_XSL_DIR}/boostbook_merge.xsl
    PATH
      ${merge_dbk_PATH}
    CATALOG
      ${BOOSTBOOK_CATALOG}
    DEPENDS
      ${merge_dbk_DEPENDS}
    COMMENT
      "merging several boostbook XMLs into one: ${rel_output} ..."
  )
endfunction()


# This functions performs merging of several boostbooks into one
function(docbook_to_fo)
  cmake_parse_arguments(fo
    ""
    "INPUT;OUTPUT"
    "PATH;DEPENDS;PARAMETERS"
    ${ARGN}

  )

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${fo_OUTPUT})

  xsltproc(
    INPUT
      ${fo_INPUT}
    OUTPUT
      ${fo_OUTPUT}
    STYLESHEET
      ${BOOSTBOOK_XSL_DIR}/fo.xsl
    PATH
      ${fo_PATH}
    CATALOG
      ${BOOSTBOOK_CATALOG}
    PARAMETERS
      ${fo_PARAMETERS}
    DEPENDS
      ${fo_DEPENDS}
    COMMENT
      "converting docbook XML to FO XML: ${rel_output} ..."
  )
endfunction()
