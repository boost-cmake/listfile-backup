# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplXsltproc)



find_program(SED_EXECUTABLE sed)

if(NOT SED_EXECUTABLE)
  message(WARNING "sed executable cannot be found, building documentation for ${Project_NAME} is not supported")
  return()
endif()



function(sed pattern input output)
  add_custom_command(
    OUTPUT
      ${output}
    COMMAND
      ${SED_EXECUTABLE} ${pattern} ${input} > ${output}
    DEPENDS
      ${input} ${ARGN}
    COMMENT
      "Performing stream editing of ${input}... with pattern ${pattern}"
  )
endfunction()


find_program(TIDY_EXECUTABLE tidy)

if(NOT TIDY_EXECUTABLE)
  message(WARNING "tidy executable cannot be found, building documentation for ${Project_NAME} is not supported")
  return()
endif()


function(tidy cfg in_html out_html)

  set(tidy_cmake_script ${in_html}.cmake)
  file(WRITE ${tidy_cmake_script})
  file(APPEND ${tidy_cmake_script} "execute_process(\n"
    "  COMMAND ${TIDY_EXECUTABLE} -ashtml -e -config ${cfg} ${in_html}\n"
    "  RESULT_VARIABLE TIDY_EXEC_STATUS\n"
    ")\n"
    "if (TIDY_EXEC_STATUS EQUAL 0)\n"
    "  message(\"tidy processing finished\")\n"
    "elseif (TIDY_EXEC_STATUS EQUAL 1)\n"
    "  message(WARNING \"tidy processing finished with warnings\")\n"
    "else()\n"
    "  message(FATAL_ERROR \"tidy processing failed\")\n"
    "endif()\n")

  add_custom_command(
    OUTPUT
      ${in_html}.tidy
    COMMAND
      ${CMAKE_COMMAND} -P ${tidy_cmake_script}
    DEPENDS
      ${in_html} ${ARGN}
    COMMENT
      "Correcting and pretty-printing ${in_html} with HTML Tidy ..."
  )

  set_source_files_properties(
    ${in_html}.tidy
    PROPERTIES
      SYMBOLIC Yes
  )

  add_custom_command(
    OUTPUT
      ${out_html}
    COMMAND
      ${CMAKE_COMMAND} -E copy_if_different ${in_html} ${out_html}
    DEPENDS
      ${in_html}.tidy
  )

endfunction()




configure_file(Doxyfile.in Doxyfile)

add_custom_command(
  OUTPUT
    ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/index.xml
  COMMAND
    ${DOXYGEN_EXECUTABLE} ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
  DEPENDS
    ${CMAKE_CURRENT_BINARY_DIR}/Doxyfile
)


function(generate_circular_buffer_doc container)

  string(REPLACE circular_buffer_ "" stripped_name ${container})
  set(html_file ${stripped_name}.html)
  set(xslt_file ${stripped_name}.xslt)

  xsltproc(
    PARAMETERS
      container=${container}
      xmldir=${CMAKE_CURRENT_BINARY_DIR}/srcdoc/
    STYLESHEET
      ${CMAKE_CURRENT_SOURCE_DIR}/${xslt_file}
    INPUT
      ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/index.xml
    OUTPUT
      ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/srcdoc_${container}.xhtml
    COMMENT
      "Converting Doxygen generated source code documentation into XHTML ..."
  )

  sed(
    "'s/<a\\s*id=\"[^\"]*\"/<a /g'"
    ${CMAKE_CURRENT_SOURCE_DIR}/${html_file}
    ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}.html.sed.intermediate

    #depends because we need output directory
    ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/srcdoc_${container}.xhtml
  )

  sed(
    "'s/<a\\s*\\(name=\"[^\"]*\"\\)\\s*\\(id=\"[^\"]*\"\\)/<a \\1/g'"
    ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}.html.sed.intermediate
    ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}_after_sed.html
  )

  xsltproc(
    HTML
    STYLESHEET
      ${CMAKE_CURRENT_SOURCE_DIR}/html2xhtml.xslt
    INPUT
      ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}_after_sed.html
    OUTPUT
      ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}.xhtml
    COMMENT
      "Converting preprocessed ${container}.html into XHTML ..."
  )

  xsltproc(
    PARAMETERS
      srcdoc=${CMAKE_CURRENT_BINARY_DIR}/srcdoc/srcdoc_${container}.xhtml
      xmldir=${CMAKE_CURRENT_BINARY_DIR}/srcdoc
    STYLESHEET
      ${CMAKE_CURRENT_SOURCE_DIR}/update_srcdoc.xslt
    INPUT
      ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}.xhtml
    OUTPUT
      ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}_raw.html
    COMMENT
      "Generating ${container}.html with updated source code documentation ..."
  )

  tidy(
    ${CMAKE_CURRENT_SOURCE_DIR}/Tidy.conf
    ${CMAKE_CURRENT_BINARY_DIR}/srcdoc/${container}_raw.html
    ${CMAKE_CURRENT_BINARY_DIR}/${html_file}
  )
endfunction()




generate_circular_buffer_doc(circular_buffer)
generate_circular_buffer_doc(circular_buffer_space_optimized)




export_documentation(
  circular_buffer
  HTML
    ${CMAKE_CURRENT_BINARY_DIR}/circular_buffer.html
    ${CMAKE_CURRENT_BINARY_DIR}/space_optimized.html
)
