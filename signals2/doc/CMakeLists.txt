# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)

ryppl_find_and_use_package(Boostbook)

add_executable(snippet_extractor
  snippet_extractor.cpp
)

set(HtmlParameters
  boost.root=../../../..
  boost.defaults=Boost
)

set(snippets_xml_dir ${CMAKE_CURRENT_BINARY_DIR})
set(snippets_xml ${snippets_xml_dir}/hello_world_def_code_snippet.xml)

file(GLOB SnippetSources ../example/*.cpp)

add_custom_command(
  OUTPUT
    ${snippets_xml}
  COMMAND
    snippet_extractor ${snippets_xml_dir} ${SnippetSources}
)


export_documentation(
  signals2
  BOOSTBOOK
    ${CMAKE_CURRENT_SOURCE_DIR}/signals.xml
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${snippets_xml}
  PATH
    ${snippets_xml_dir}
)
