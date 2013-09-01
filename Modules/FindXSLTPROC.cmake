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

find_package(XSLTPROC QUIET NO_MODULE)

if(XSLTPROC_FOUND)
  set(XSLTPROC_EXECUTABLE $<TARGET_FILE:xsltproc>)
else()
  find_program(XSLTPROC_EXECUTABLE
    NAMES
      xsltproc
    DOC
      "the xsltproc tool"
    )
  if(XSLTPROC_EXECUTABLE)
    execute_process(COMMAND ${XSLTPROC_EXECUTABLE} --version
      OUTPUT_VARIABLE XSLTPROC_VERSION
	  RESULT_VARIABLE XSLTPROC_RESULT
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
	if (NOT XSLTPROC_RESULT EQUAL 0)
	  #message(STATUS "xsltproc: returns status ${XSLTPROC_RESULT}, possibly xsltproc is broken")
	  set(XSLTPROC_EXECUTABLE XSLTPROC_EXECUTABLE-NOTFOUND)
	else()
      string(REGEX MATCH "libxslt ([0-9])0([0-9])([0-9][0-9])"
        XSLTPROC_VERSION "${XSLTPROC_VERSION}"
      )
      set(XSLTPROC_VERSION
        "${CMAKE_MATCH_1}.${CMAKE_MATCH_2}.${CMAKE_MATCH_3}"
      )
	endif()
  endif()
  include(FindPackageHandleStandardArgs)
  find_package_handle_standard_args(XSLTPROC
    REQUIRED_VARS XSLTPROC_EXECUTABLE
    VERSION_VAR XSLTPROC_VERSION
  )
endif()
