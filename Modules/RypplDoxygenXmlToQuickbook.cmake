# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(CMakeParseArguments)


ryppl_find_and_use_package(DoxygenXmlToQuickbook)


function(doxyxml_to_quickbook)
  cmake_parse_arguments(doxyxml2qbk
    "" # no options
    "XML;START_INCLUDE;CONVENIENCE_HEADER_PATH;SKIP_NAMESPACE;COPYRIGHT;OUTPUT" # one value params
    "CONVENIENCE_HEADERS;DEPENDS" # multi value params
    ${ARGN}
  )

  foreach(convHeader ${doxyxml2qbk_CONVENIENCE_HEADERS})
    set(convenience_headers "${convenience_headers},${convHeader}")
  endforeach()

  file(RELATIVE_PATH rel_output ${CMAKE_BINARY_DIR} ${doxyxml2qbk_XML})

  add_custom_command(
    COMMAND
      doxygen_xml2qbk
        --xml ${doxyxml2qbk_XML}
        --start_include ${doxyxml2qbk_START_INCLUDE}
        --convenience_headers ${convenience_headers}
        --skip_namespace ${doxyxml2qbk_SKIP_NAMESPACE}
        --copyright ${doxyxml2qbk_COPYRIGHT}
        --output ${doxyxml2qbk_OUTPUT}
    OUTPUT
      ${doxyxml2qbk_OUTPUT}
    DEPENDS
      ${doxyxml2qbk_DEPENDS}
      ${doxyxml2qbk_XML}
    COMMENT "Converting doxygen XML to quickbook: ${rel_output} ..."
  )
endfunction()

