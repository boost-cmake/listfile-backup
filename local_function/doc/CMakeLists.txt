# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)

set (LocalFunctionHeaders
  ../include/boost/local_function.hpp
  ../include/boost/local_function/config.hpp
)

set(DoxygenParameters
  PREDEFINED="DOXYGEN"
  QUIET=YES
  WARN_IF_UNDOCUMENTED=NO
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_CLASSES=YES
  ALIASES=" Params=\"<b>Parameters:</b> <table border="0">\" Param{2}=\"<tr><td><b><tt>\\1</tt></b></td><td>\\2</td></tr>\" EndParams=\"</table>\" Returns=\"<b>Returns:</b>\" Note=\"<b>Note:</b>\" Warning=\"<b>Warning:</b>\" See=\"<b>See:</b>\" RefSect{2}=\"\\xmlonly<link linkend='boost_localfunction.\\1'>\\2</link>\\endxmlonly\" RefClass{1}=\"\\xmlonly<computeroutput><classname alt='\\1'>\\1</classname></computeroutput>\\endxmlonly\" RefFunc{1}=\"\\xmlonly<computeroutput><functionname alt='\\1'>\\1</functionname></computeroutput>\\endxmlonly\" RefMacro{1}=\"\\xmlonly<computeroutput><macroname alt='\\1'>\\1</macroname></computeroutput>\\endxmlonly\" "
)

set(reference_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${LocalFunctionHeaders}
  OUTPUT
    ${reference_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Reference"
)



set(local_function_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/local_function_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/local_function.qbk
  ${local_function_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${CMAKE_CURRENT_BINARY_DIR}
)

set (HtmlParameters
  boost.defaults=Boost
  boost.root=../../../..
)

export_documentation(
  local_function
  BOOSTBOOK
    ${local_function_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${reference_bbk_xml}
)
