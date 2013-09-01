# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplDocUtils)

ryppl_find_and_use_package(Boostbook)


set(RstInputs
  associative_ptr_container
  conventions
  examples
  faq
  guidelines
  headers
  indirect_fun
  ptr_array
  ptr_container
  ptr_deque
  ptr_inserter
  ptr_list
  ptr_map_adapter
  ptr_map
  ptr_multimap_adapter
  ptr_multimap
  ptr_multiset_adapter
  ptr_multiset
  ptr_sequence_adapter
  ptr_set_adapter
  ptr_set
  ptr_vector
  reference
  reversible_ptr_container
  tutorial
)


foreach(rst ${RstInputs})
  rst2html(
    INPUT
      ${CMAKE_CURRENT_SOURCE_DIR}/${rst}.rst
    OUTPUT
      ${CMAKE_CURRENT_BINARY_DIR}/${rst}.html
  )

  list(APPEND HtmlGeneratedDepsList ${CMAKE_CURRENT_BINARY_DIR}/${rst}.html)
endforeach()




set(HtmlParameters
  boost.root=../../../..
)

export_documentation(
  ptr_container
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/ptr_container.xml
  HTML_PARAMETERS
    ${HtmlParameters}
  PATH
    ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS
    ${HtmlGeneratedDepsList}
)

