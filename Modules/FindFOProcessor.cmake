# Find an XSL-FO processor (FOP or XEP)

#=============================================================================
# Copyright (C) 2010-2011 Daniel Pfeifer <daniel@pfeifer-mail.de>
#
# Distributed under the Boost Software License, Version 1.0.
# See accompanying file LICENSE_1_0.txt or copy at
#   http://www.boost.org/LICENSE_1_0.txt
#=============================================================================

include(CMakeParseArguments)
include(FindPackageHandleStandardArgs)

find_program(FO_PROCESSOR
  NAMES
    fop
    xep.bat
  PATHS
    ${FOP_EXTRA_DIRECTORY}
    $ENV{PROGRAMFILES}/RenderX/XEP
  DOC
    "An XSL-FO processor"
)

find_package_handle_standard_args(FOProcessor
  REQUIRED_VARS FO_PROCESSOR
)


function(fo_xml_to_pdf)
  if(NOT FOPROCESSOR_FOUND)
    return()
  endif()

  cmake_parse_arguments(pdf
    ""
    "INPUT;OUTPUT"
    "DEPENDS"
    ${ARGN}

  )

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${pdf_OUTPUT})

  add_custom_command(
    OUTPUT
      ${pdf_OUTPUT}
    COMMAND
      ${FO_PROCESSOR} ${pdf_INPUT} ${pdf_OUTPUT}
    DEPENDS
      ${pdf_INPUT} ${pdf_DEPENDS}
    COMMENT
      "converting fo-xml to pdf: ${rel_output} ..."
  )
endfunction()
