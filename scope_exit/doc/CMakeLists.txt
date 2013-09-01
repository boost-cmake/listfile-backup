# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


set(ScopeExitHeaders
  ../include/boost/scope_exit.hpp
)

set(DoxygenParameters
  PREDEFINED="DOXYGEN"
  QUIET=YES
  WARN_IF_UNDOCUMENTED=NO
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_CLASSES=YES
  ALIASES=" Params=\"<b>Parameters:</b> <table border="0">\" Param{2}=\"<tr><td><b><tt>\\1</tt></b></td><td>\\2</td></tr>\" EndParams=\"</table>\" Returns=\"<b>Returns:</b>\" Note=\"<b>Note:</b>\" Warning=\"<b>Warning:</b>\" See=\"<b>See:</b>\" RefSect{2}=\"\\xmlonly<link linkend='scope_exit.\\1'>\\2</link>\\endxmlonly\" RefClass{1}=\"\\xmlonly<computeroutput><classname alt='\\1'>\\1</classname></computeroutput>\\endxmlonly\" RefFunc{1}=\"\\xmlonly<computeroutput><functionname alt='\\1'>\\1</functionname></computeroutput>\\endxmlonly\" RefMacro{1}=\"\\xmlonly<computeroutput><macroname alt='\\1'>\\1</macroname></computeroutput>\\endxmlonly\" "
)



set(reference_xml ${CMAKE_CURRENT_BINARY_DIR}/reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${ScopeExitHeaders}
  OUTPUT
    ${reference_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Reference"
)


set(scope_exit_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/scope_exit_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/scope_exit.qbk
  ${scope_exit_bbk_gen_xml}
  INCLUDE
    ${CMAKE_CURRENT_SOURCE_DIR}
  DEPENDS
    ${reference_xml}
)

set(HtmlParameters
  boost.root=../../../..
  boost.defaults=Boost
)


export_documentation(
  scope_exit
  BOOSTBOOK
    ${scope_exit_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
)
