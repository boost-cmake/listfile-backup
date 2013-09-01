

include(CMakeParseArguments)

find_package(PythonInterp)

find_program(RST2HTML_PROGRAM rst2html NAMES rst2html.py)


function (rst2html)
  if (NOT RST2HTML_PROGRAM)
    return()
  endif()

  if (NOT PYTHONINTERP_FOUND)
    return()
  endif()

  cmake_parse_arguments(DOCUTILS
    ""
    "INPUT;OUTPUT"
    "DEPENDS;PARAMETERS;"
    ${ARGN}
  )

  if (NOT DOCUTILS_INPUT AND NOT DOCUTILS_OUTPUT)
    message(FATAL_ERROR "rst2html: necessary parameters INPUT and OUTPUT is not set")
  endif()

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${DOCUTILS_OUTPUT})

  add_custom_command(
    OUTPUT
      ${DOCUTILS_OUTPUT}
    COMMAND
      ${PYTHON_EXECUTABLE} ${RST2HTML_PROGRAM} ${DOCUTILS_INPUT} ${DOCUTILS_OUTPUT} ${DOCUTILS_PARAMETERS}
    DEPENDS
      ${DOCUTILS_DEPENDS} ${DOCUTILS_INPUT}
    COMMENT
      "converting rst to html ${rel_output}"
  )

endfunction()
