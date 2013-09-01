# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set(DoxygenParameters
  PREDEFINED="DOXYGEN"
  QUIET=YES
  WARN_IF_UNDOCUMENTED=NO
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_CLASSES=YES
  ALIASES=" Params=\"<b>Parameters:</b> <table border="0">\" Param{2}=\"<tr><td><b><tt>\\1</tt></b></td><td>\\2</td></tr>\" EndParams=\"</table>\" Returns=\"<b>Returns:</b>\" Note=\"<b>Note:</b>\" Warning=\"<b>Warning:</b>\" See=\"<b>See:</b>\" RefSect{2}=\"\\xmlonly<link linkend='boost_functional_overloadedfunction.\\1'>\\2</link>\\endxmlonly\" RefClass{1}=\"\\xmlonly<computeroutput><classname alt='\\1'>\\1</classname></computeroutput>\\endxmlonly\" RefFunc{1}=\"\\xmlonly<computeroutput><functionname alt='\\1'>\\1</functionname></computeroutput>\\endxmlonly\" RefMacro{1}=\"\\xmlonly<computeroutput><macroname alt='\\1'>\\1</macroname></computeroutput>\\endxmlonly\" "
)


set(FunctionalOverloadedFunctionHeaders
  ../../include/boost/functional/overloaded_function.hpp
  ../../include/boost/functional/overloaded_function/config.hpp
)

set(overloaded_function_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${FunctionalOverloadedFunctionHeaders}
  OUTPUT
    ${overloaded_function_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)

quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/overloaded_function.qbk
  overloaded_function_generated.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
  XINCLUDE_BASE
    ${CMAKE_CURRENT_SOURCE_DIR}
)


set(HtmlParameters
  boost.root=../../../../..
  boost.libraries=../../../../libraries.htm
  chunk.section.depth=0
  chunk.first.sections=0
  generate.section.toc.level=2
  toc.max.depth=1
)

export_documentation(
  overloaded_function
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/overloaded_function_generated.xml
  DEPENDS
    ${overloaded_function_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
