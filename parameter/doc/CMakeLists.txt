# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplDocUtils)


set(RstInputs
  index
  python
  reference
)


foreach(rst ${RstInputs})
  rst2html(
    INPUT
      ${CMAKE_CURRENT_SOURCE_DIR}/${rst}.rst
    OUTPUT
      ${CMAKE_CURRENT_BINARY_DIR}/${rst}.html
    PARAMETERS
      -gdt
      --link-stylesheet
      --traceback
      --trim-footnote-reference-space
      --footnote-references=superscript
      --stylesheet=rst.css
  )

  list(APPEND HtmlGeneratedList ${CMAKE_CURRENT_BINARY_DIR}/${rst}.html)
endforeach()

export_documentation(
  parameter
  HTML
    ${HtmlGeneratedList}
)

