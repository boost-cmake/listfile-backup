# Create a custom command to generate doxygen XML.
#
#   ryppl_doxygen(<name> [XML] [TAG]
#     [DOXYFILE <doxyfile>]
#     [INPUT <input files>]
#     [TAGFILES <tagfiles>]
#     [PARAMETERS <parameters>]
#     )

#=============================================================================
# Copyright (C) 2008 Douglas Gregor <doug.gregor@gmail.com>
# Copyright (C) 2011 Daniel Pfeifer <daniel@pfeifer-mail.de>
#
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

find_package(XSLTPROC QUIET)


# Find the xsltproc tool.
#
#   XSLTPROC_EXECUTABLE - path to the xsltproc executable
#   XSLTPROC_FOUND      - true if xsltproc was found
#   XSLTPROC_VERSION    - the version of xsltproc found
#
# If xsltproc was found, this module provides the following function:
#
#   xsltproc(<output> <stylesheet> <input>
#     [PARAMETERS param1=value1 param2=value2 ...]
#     [CATALOG <catalog file>]
#     [DEPENDS <dependancies>]
#     )
#
# This function builds a custom command that transforms an XML file
# (input) via the given XSL stylesheet.
#
# The PARAMETERS argument is followed by param=value pairs that set
# additional parameters to the XSL stylesheet. The parameter names
# that can be used correspond to the <xsl:param> elements within the
# stylesheet.
#
# Additional dependancies may be passed via the DEPENDS argument.
# For example, dependancies might refer to other XML files that are
# included by the input file through XInclude.

#=============================================================================
# Copyright (C) 2010-2011 Daniel Pfeifer <daniel@pfeifer-mail.de>
#
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

#find_package(XSLTPROC QUIET NO_MODULE)

include(CMakeParseArguments)

if(NOT XSLTPROC_FOUND)
  set(RYPPL_DISABLE_DOCS Yes)
endif()

macro(transform_to_xml_url2 input output)
  if (WIN32 AND NOT CYGWIN)
    set(${output} "file:///${${input}}")
  else()
    set(${output} ${${input}})
  endif()
endmacro()

macro(transform_to_xml_url input)
  transform_to_xml_url2(${input} ${input})
endmacro()

function(xsltproc)
  if(RYPPL_DISABLE_DOCS)
    return()
  endif()

  cmake_parse_arguments(XSL
    "HTML"
    "CATALOG;STYLESHEET;OUTPUT;COMMENT"
    "DEPENDS;INPUT;PARAMETERS;PATH"
    ${ARGN}
    )

  if(NOT XSL_STYLESHEET OR NOT XSL_INPUT OR NOT XSL_OUTPUT)
    message(FATAL_ERROR "xsltproc command requires STYLESHEET, INPUT and OUTPUT!")
  endif()

  file(RELATIVE_PATH name "${CMAKE_CURRENT_BINARY_DIR}" "${XSL_OUTPUT}")
  string(REGEX REPLACE "[./]" "_" name ${name})
  set(script "${CMAKE_CURRENT_BINARY_DIR}/${name}.cmake")

  string(REPLACE " " "%20" catalog "${XSL_CATALOG}")
  transform_to_xml_url(catalog)

  if(XSL_HTML)
    set(XSL_EXTRA_PARAMETERS ${XSL_EXTRA_PARAMETERS} --html)
  endif()

  file(WRITE ${script}
    "set(ENV{XML_CATALOG_FILES} \"${catalog}\")\n"
    "execute_process(COMMAND \${XSLTPROC} --xinclude --nonet ${XSL_EXTRA_PARAMETERS}\n"
    )

  # Translate XSL parameters into a form that xsltproc can use.
  foreach(param ${XSL_PARAMETERS})
    string(REGEX REPLACE "([^=]*)=([^;]*)" "\\1;\\2" name_value ${param})
    list(GET name_value 0 name)
    list(GET name_value 1 value)
    file(APPEND ${script} "  --stringparam ${name} ${value}\n")
  endforeach()

  # add paths for searching resources
  foreach(path_entry ${XSL_PATH})
    transform_to_xml_url(path_entry)
    file(APPEND ${script} " --path \"${path_entry}\"")
  endforeach()

  transform_to_xml_url2(XSL_OUTPUT xml_xsl_output)
  transform_to_xml_url2(XSL_STYLESHEET xml_xsl_stylesheet)
  # add input file list
  file(APPEND ${script}
    "  -o \"${xml_xsl_output}\" \"${xml_xsl_stylesheet}\""
    )

  foreach(input_file ${XSL_INPUT})
    transform_to_xml_url(input_file)
    file(APPEND ${script}
      " \"${input_file}\""
      )
  endforeach()

  file(APPEND ${script}
    "\n"
    "  RESULT_VARIABLE result\n"
    "  )\n"
    "if(NOT result EQUAL 0)\n"
    "  message(FATAL_ERROR \"xsltproc returned \${result}\")\n"
    "endif()\n"
  )

  if (NOT XSL_COMMENT)
    set (XSL_COMMENT "performing xslt transformation for file ${XSL_INPUT} ...")
  endif()

  # Run the XSLT processor to do the XML transformation.
  add_custom_command(OUTPUT ${XSL_OUTPUT}
    COMMAND ${CMAKE_COMMAND} -DXSLTPROC=${XSLTPROC_EXECUTABLE} -P ${script}
    DEPENDS ${XSL_STYLESHEET} ${XSL_INPUT} ${XSL_DEPENDS}
    COMMENT "${XSL_COMMENT}"
    )
endfunction()
