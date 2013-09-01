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


if(CMAKE_HOST_WIN32)
  set(dev_null NUL)
else()
  set(dev_null /dev/null)
endif()

find_package(Boostbook QUIET)
find_package(DBLATEX QUIET)
find_package(FOProcessor QUIET)
find_package(HTMLHelp QUIET)

include(RypplXsltTransformations)

get_filename_component(Ryppl_RESOURCE_PATH
  "${CMAKE_CURRENT_LIST_DIR}/../Resources" ABSOLUTE CACHE
  )

function(ryppl_documentation input)
  if(RYPPL_DISABLE_DOCS)
    return()
  endif()

  set(doc_targets)
  set(html_dir "${CMAKE_CURRENT_BINARY_DIR}/html")

  file(COPY
      "${Ryppl_RESOURCE_PATH}/images"
      "${Ryppl_RESOURCE_PATH}/ryppl.css"
    DESTINATION
      "${html_dir}"
    )

  get_filename_component(ext ${input} EXT)
  get_filename_component(name ${input} NAME_WE)
  get_filename_component(input ${input} ABSOLUTE)

  if(HTML_HELP_COMPILER)
    set(hhp_output "${html_dir}/htmlhelp.hhp")
    set(chm_output "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.chm")
    xsltproc(
      INPUT      ${input}
      OUTPUT     ${hhp_output}
      CATALOG    ${BOOSTBOOK_CATALOG}
      STYLESHEET ${BOOSTBOOK_XSL_DIR}/htmlhelp.xsl
      PARAMETERS "htmlhelp.chm=../${PROJECT_NAME}.chm"
      )
    set(hhc_cmake ${CMAKE_CURRENT_BINARY_DIR}/hhc.cmake)
    file(WRITE ${hhc_cmake}
      "execute_process(COMMAND \"${HTML_HELP_COMPILER}\" htmlhelp.hhp"
      " WORKING_DIRECTORY \"${html_dir}\" OUTPUT_QUIET)"
      )
    add_custom_command(OUTPUT ${chm_output}
      COMMAND "${CMAKE_COMMAND}" -P "${hhc_cmake}"
      DEPENDS ${hhp_output}
      )
    list(APPEND doc_targets ${chm_output})
    install(FILES    "${chm_output}"
      DESTINATION    "doc"
      COMPONENT      "doc"
      CONFIGURATIONS "Release"
      )
  else() # generate HTML and manpages
    set(output_html "${html_dir}/index.html")
    xsltproc(
      INPUT      ${input}
      OUTPUT     ${output_html}
      CATALOG    ${BOOSTBOOK_CATALOG}
      STYLESHEET ${BOOSTBOOK_XSL_DIR}/xhtml.xsl
      )
    list(APPEND doc_targets ${output_html})
#   set(output_man  ${CMAKE_CURRENT_BINARY_DIR}/man/man.manifest)
#   xsltproc(${output_man} ${BOOSTBOOK_XSL_DIR}/manpages.xsl ${input})
#   list(APPEND doc_targets ${output_man})
    install(DIRECTORY "${html_dir}/"
      DESTINATION     "share/doc/${PROJECT_NAME}"
      COMPONENT       "doc"
      CONFIGURATIONS  "Release"
      )
  endif()

  set(target "${PROJECT_NAME}-doc")
  add_custom_target(${target} DEPENDS ${doc_targets})
  set_target_properties(${target} PROPERTIES
    FOLDER "${PROJECT_NAME}"
    PROJECT_LABEL "${PROJECT_NAME} (documentation)"
    )
  add_dependencies(documentation ${target})

  # build documentation as pdf
  if(DBLATEX_FOUND OR FOPROCESSOR_FOUND)
    set(pdf_dir ${CMAKE_BINARY_DIR}/pdf)
    set(pdf_file ${pdf_dir}/${PROJECT_NAME}.pdf)
    file(MAKE_DIRECTORY ${pdf_dir})

    if(FOPROCESSOR_FOUND)
      set(fop_file ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.fo)
      xsltproc(
        INPUT      ${input}
        OUTPUT     ${fop_file}
        CATALOG    ${BOOSTBOOK_CATALOG}
        STYLESHEET ${BOOSTBOOK_XSL_DIR}/fo.xsl
        PARAMETERS "img.src.path=${CMAKE_CURRENT_BINARY_DIR}/images/"
        )
      add_custom_command(OUTPUT ${pdf_file}
        COMMAND ${FO_PROCESSOR} ${fop_file} ${pdf_file} 2>${dev_null}
        DEPENDS ${fop_file}
        WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
        )
    elseif(DBLATEX_FOUND)
      add_custom_command(OUTPUT ${pdf_file}
        COMMAND ${DBLATEX_EXECUTABLE} -o ${pdf_file} ${input} 2>${dev_null}
        DEPENDS ${input}
        )
    endif()

    set(target "${PROJECT_NAME}-pdf")
    add_custom_target(${target} DEPENDS ${pdf_file})
    set_target_properties(${target} PROPERTIES
      FOLDER "${PROJECT_NAME}"
      PROJECT_LABEL "${PROJECT_NAME} (pdf)"
      )
  endif()
endfunction()




# This function adds file as dependency to `documentation` target
# For example you may pass `manifest` file
# (which generated in function xslt_docbook_to_html) as input parameter
function(generate_standalone_doc type input)
  if(RYPPL_DISABLE_DOCS)
    return()
  endif()

  set(target_name "${PROJECT_NAME}-${type}")
  add_custom_target(${target_name} DEPENDS ${input} ${ARGN})

  add_dependencies(documentation ${target_name})

endfunction()



function(generate_config_for_documentation doc_target out_file boostbook)
  file(WRITE ${out_file} "# This file is generated with boost build\n# Do not edit !!!\n\n")

  if (boostbook)

    get_filename_component(boostbook_full_name ${boostbook} ABSOLUTE)
    get_filename_component(boostbook_entry_path ${boostbook_full_name} PATH)
    file(APPEND ${out_file} "set(${doc_target}_BOOSTBOOK ${boostbook_full_name})\n")
    file(APPEND ${out_file} "set(${doc_target}_BOOSTBOOK_PATH ${boostbook_entry_path})\n\n")

    file(APPEND ${out_file} "list(APPEND BOOSTBOOK_GENERATED_PATH \${${doc_target}_BOOSTBOOK_PATH})\n")
    file(APPEND ${out_file} "list(APPEND DOCUMENTATION_DEPENDENCIES ${boostbook})\n")

    #file(APPEND ${out_file} "list(APPEND DOCUMENTATION_DEPENDENCIES ${deps})")

    foreach(path_entry ${doc_export_BOOSTBOOK_PATH})
      file(APPEND ${out_file} "list(APPEND BOOSTBOOK_GENERATED_PATH ${path_entry})\n")
    endforeach()

  endif()

  file(APPEND ${out_file} "\n")

  export(PACKAGE ${doc_target})
endfunction()


# TODO add description
function(export_documentation export_name)
  if(RYPPL_DISABLE_DOCS)
    return()
  endif()

  cmake_parse_arguments(doc_export
    "ONEHTML"
    "BOOSTBOOK;DOCBOOK"
    "PATH;DEPENDS;HTML_PARAMETERS;AUTOINDEX_PARAMETERS;PDF_PARAMETERS;HTML"
    ${ARGN}
  )

  if (NOT doc_export_BOOSTBOOK AND NOT doc_export_DOCBOOK AND NOT doc_export_HTML)
    message(FATAL_ERROR "Necessary parameter BOOSTBOOK, DOCBOOK or HTML is not set")
  endif()

  set(full_export_name ${CMAKE_CURRENT_BINARY_DIR}/${export_name}.xml)

  if (NOT doc_export_HTML)
    set(export_file_created 0)

    set(DOC_TARGET ${PROJECT_NAME}Doc)
    add_custom_target(
      ${DOC_TARGET}
      DEPENDS
	${full_export_name}
    )

    set(out_file "${CMAKE_CURRENT_BINARY_DIR}/${DOC_TARGET}Config.cmake")
    generate_config_for_documentation(${DOC_TARGET} ${out_file} ${full_export_name})

    add_dependencies(documentation ${DOC_TARGET})
  else()
    # Actually we does not have any export XML file,
    # but we need it to correct behavior of this function
    set(export_file_created 1)
  endif()

  if (doc_export_BOOSTBOOK)
    set(merged_boostbook ${full_export_name})

    merge_boostbook(
      INPUT
        ${doc_export_BOOSTBOOK}
      OUTPUT
        ${merged_boostbook}
      PATH
        ${doc_export_PATH}
        ${CMAKE_CURRENT_BINARY_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}
      DEPENDS
        ${doc_export_DEPENDS}
    )

    set(export_file_created 1)

    unset(doc_export_DEPENDS)

    # Now generate docbook XML for further processing
    set(doc_export_DOCBOOK ${full_export_name}.docbook)
    xslt_boostbook_to_docbook(
      INPUT
        ${full_export_name}
      OUTPUT
        ${doc_export_DOCBOOK}
    )

  endif(doc_export_BOOSTBOOK)

  if (doc_export_DOCBOOK)
    # Generate index with autoindex
    if (doc_export_AUTOINDEX_PARAMETERS)
      set(docbook_indexed ${doc_export_DOCBOOK}.indexed)
      generate_index(
        INPUT
          ${doc_export_DOCBOOK}
        OUTPUT
          ${docbook_indexed}
        ${doc_export_AUTOINDEX_PARAMETERS}
      )
    else()
      set(docbook_indexed ${doc_export_DOCBOOK})
    endif()

    # Now generates standalone documentation
    set(html_dir "${CMAKE_CURRENT_BINARY_DIR}/html")

    if (NOT doc_export_ONEHTML)
      set(doc_export_HTML ${html_dir}/${PROJECT_NAME}_HTML.manifest)
      xslt_docbook_to_html(
        INPUT
          ${docbook_indexed}
        OUTPUT
          ${html_dir}
        PARAMETERS
          ${doc_export_HTML_PARAMETERS}
        MANIFEST
          ${doc_export_HTML}
        DEPENDS
          ${doc_export_DEPENDS}
      )
    else()
      set(doc_export_HTML ${html_dir}/${export_name}.html)
      xslt_docbook_to_single_html(
        INPUT
          ${docbook_indexed}
        OUTPUT
          ${doc_export_HTML}
        PARAMETERS
          ${doc_export_HTML_PARAMETERS}
        DEPENDS
          ${doc_export_DEPENDS}
      )
    endif()

    if (${docbook_indexed} EQUAL ${full_export_name})
      set(export_file_created 1)
    endif()

    if (NOT export_file_created)
      # creating export file
      add_custom_command(
        OUTPUT
          ${full_export_name}
        COMMAND ${CMAKE_COMMAND} -E copy_if_different ${docbook_indexed} ${full_export_name}
        DEPENDS ${docbook_indexed}
        COMMENT "copying docbook ${export_name}.xml to final destination..."
      )
      set(export_file_created 1)
    endif()

  endif()

  if (NOT export_file_created)
    message(FATAL_ERROR "${export_name}: export file is not constructed")
  endif()

  generate_standalone_doc(html ${doc_export_HTML})

  if (docbook_indexed)
    set(pdf_file ${CMAKE_CURRENT_BINARY_DIR}/${export_name}.pdf)
    if(FOPROCESSOR_FOUND)
      set(fop_file ${CMAKE_CURRENT_BINARY_DIR}/${export_name}.fo)
      docbook_to_fo(
        INPUT
          ${docbook_indexed}
        OUTPUT
          ${fop_file}
        PARAMETERS
          ${doc_export_PDF_PARAMETERS}
      )

      fo_xml_to_pdf(
        INPUT
          ${fop_file}
        OUTPUT
          ${pdf_file}
      )
    elseif(DBLATEX_FOUND)
      add_custom_command(
        OUTPUT
          ${pdf_file}
        COMMAND
          ${DBLATEX_EXECUTABLE} -o ${pdf_file} ${docbook_indexed}
        DEPENDS
          ${docbook_indexed}
        COMMENT
          "converting docbook XML to pdf: ${export_name} ..."
      )
    else()
      # no PDF generators available
      unset(pdf_file)
    endif()
  endif()

  if(pdf_file)
    install(
      FILES
        ${pdf_file}
      DESTINATION
        share/doc/pdf
    )

    generate_standalone_doc(pdf ${pdf_file})
  endif()

endfunction()
