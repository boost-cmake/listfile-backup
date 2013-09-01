# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


file (GLOB OdeIntHeaders
  ../include/boost/numeric/odeint/stepper/*.hpp
  ../include/boost/numeric/odeint/stepper/base/*.hpp
  ../include/boost/numeric/odeint/integrate/*.hpp
)

set(DoxygenParameters
  WARNINGS=YES
  WARN_LOGFILE=AutoDoxywarnings.log
  WARN_IF_UNDOCUMENTED=NO # Default NO but useful if you aim to Doxygen document *all* members.
  QUIET=NO
  WARN_NO_PARAMDOC=NO # Default no, but YES useful if you aim to document all function parameters.
  DOXYFILE_ENCODING=UTF-8
  PROJECT_NAME="odeint"
  PROJECT_NUMBER=2.2
  TAB_SIZE=2
  SORT_MEMBER_DOCS=NO
  SORT_BRIEF_DOCS=NO
  SORT_MEMBERS_CTORS_1ST=NO
  EXTRACT_PRIVATE=NO
  INLINE_INHERITED_MEMB=YES
  INHERIT_DOCS=YES
  EXTRACT_STATIC=YES
  EXTRACT_ANON_NSPACES=NO
  EXTRACT_LOCAL_CLASSES=YES
  EXTRACT_LOCAL_METHODS=YES
  HIDE_UNDOC_MEMBERS=NO
  HIDE_UNDOC_CLASSES=YES
  HIDE_FRIEND_COMPOUNDS=NO
  #HIDE_INBODY_DOCS=NO
  INTERNAL_DOCS=YES
  CASE_SENSE_NAMES=NO
  HIDE_SCOPE_NAMES=NO

  # Preprocessor settings.
  # Some ugly examples of predefined macro calls (from Boost.Units library) :(
  "PREDEFINED= \\
    \"BOOST_UNITS_STATIC_CONSTANT(a,b)=static const b a\" \\
    \"BOOST_UNITS_TYPEOF(a)=typeof(a)\" \\
    \"BOOST_PREVENT_MACRO_SUBSTITUTION=\" \\
    \"BOOST_UNITS_HAS_TYPEOF=1\" \\
    \"DOXYGEN_SKIP=1\" "

  ENABLE_PREPROCESSING=YES # Evaluates all C-preprocessor directives found in files.
  MACRO_EXPANSION=YES # Will expand all macro names.
  EXPAND_ONLY_PREDEF=YES # Only predefined macros expanded.  See units library for an example.
  SEARCH_INCLUDES=YES # Search #include files found.
  INLINE_INFO=YES # If the INLINE_INFO tag is set to YES (the default) then a tag [inline] is inserted in the documentation for inline members.

  SHOW_INCLUDE_FILES=NO # List of the files that are included by a file in the documentation of that file.
  REPEAT_BRIEF=YES # Prepend the brief description of a member or function before the detailed description
  BRIEF_MEMBER_DESC=YES # Include brief member descriptions after the members that are listed in the file and class
  MULTILINE_CPP_IS_BRIEF=YES # Treat a multi-line C++ special comment block (i.e. a block of //! or /// comments) as a brief description.
  # May be best to always use \brief and \details to avoid ambiguity?
  #STRIP_FROM_PATH=NO # Most useful to leave default to strip just the directory from which Doxygen is run.
  # Yes gives the full path, but NO is more useful, only giving enough to be
  #CPP_CLI_SUPPORT=NO # unless, most unusually, you are compiled for a 'managed' CLI application.
  SHOW_USED_FILES=YES # Default YES to show a list files used to generate documention.
  SHOW_DIRECTORIES=YES # Default NO, but useful to show directory heirarchy.
  SHOW_FILES=YES # Default YES is to include a tab for a page of files listed.  Useful.
  SHOW_NAMESPACES=YES # Default YES to include tab for list of namespaces.  Useful if you have namespacess other than boost::
  FILE_PATTERNS= # Types of files to be used as input. Default includes *.c *.cc *.cxx *.cpp *.c++ *.ipp *.i++ *.inl *.h *.hh *.hxx *.hpp *.h++ *.py
  #  Might include .qbk?

  RECURSIVE=YES # Search recursively down subdirectories.
  EXCLUDE= # Files or directories that should be excluded from INPUT source files.
  #  Headers and footers are actually rather attractive,
  #    HTML_HEADER="doxygen/checks_doxygen_header.html" # A sample including a draft stamp and 'Not_Yet_In_Boost' logo.
  #  Take care that if you use this (recommended), you need to ensure that the html
  #    HTML_FOOTER="doxygen/checks_doxygen_footer.html" # This is very useful to add copyright, date of revision, versioning etc.

  # A custom stylesheet is also useful, as the default syntax coloring is 'unusual' ;-)
  HTML_STYLESHEET="doxygen/doxygen.css" # Placed in the doxygen directory,
  # this will change to your choice of C++ syntax coloring when viewing source from Doxygen.
  # Users can place (or edit) their own personal choice CSS file here.
)



set(reference_xml ${CMAKE_CURRENT_BINARY_DIR}/reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${OdeIntHeaders}
  OUTPUT
    ${reference_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  XSLT_PARAMETERS
    boost.doxygen.reftitle="odeint Reference"
)


set(odeint_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/odeint_generated.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/odeint.qbk
  ${odeint_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
  DEFINES
    enable_index
)

set (HtmlParameters
  # Path for links to Boost:
  #<xsl:param>boost.root=\$(local-boost-root) # Link to Boost logo boost.png
  # Links are relative and trying to make absolute does NOT work.
  # And remember that all links MUST (unless in quotes) use  backslash, not forward that is trip char.

  boost.root=../../../../.. # OK but link to I:/boost_trunk/boost.png

  # Also control links to admonitions, so need to set separately.
  #<xsl:param>boost.root=../../../../../../../boost_1_47_0 # OK file:///I:/boost_1_48_0/boost.png
  # Quickbook [@boost:/boost/units/detail/utility.hpp] should make it relative to xsl parameter boost.root.

  # Use the your own local Boost stylesheet:
  # <xsl:param>html.stylesheet=../html/boostbook.css

  # Some general style settings:
  #   see http://docbook.sourceforge.net/release/xsl/current/doc/html/index.html
  table.footnote.number.format=1 # Identifies the format used for footnote numbers in tables.
  footnote.number.format=1 # Identifies the format used for text footnote numbers.

  # Default to not including the Boost logo in the navbar, when one expressly asks to include the navbar.
  # Boost jamroot now includes
  # Default to not include a navbar.
  #<xsl:param>nav.layout=none # No navigation bar (home, prev, next).
  # defining creates a runtime error: Global parameter nav.layout already defined
  #<xsl:param>nav.layout=horizontal # to get a horizontal navigation bar (you probably DO want this).

  boost.image.src=logo.jpg #
  boost.image.width=294 # Width of logo in pixels.
  boost.image.height=127 # Height of logo in pixels.


  # HTML options:
  # ------------
  navig.graphics=1  # Use graphics not text for navigation.
  chunk.section.depth=2  # How far down we chunk nested sections, basically all of them.
  chunk.first.sections=1  # Don't put the first section on the same page as the TOC.
  toc.section.depth=2  # How far down sections get TOCs.
  toc.max.depth=2  # Max depth in each TOC.
  generate.section.toc.level=3  # How far down we go with TOCs.

  #<format>html:<xsl:param>admon.graphics.extension=".png"  # default type for admonitions (important, warning, note ...)
  #<format>html:<xsl:param>admon.graphics.path=$(nav-images)/ # path to admonition (warning, note...) image (.png) files.

  # <xsl:param name="draft.watermark.image">http://docbook.sourceforge.net/release/images/draft.png</xsl:param>
  # but use a local copy of draft.png.
)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/odeint.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/
)

export_documentation(
  odeint
  BOOSTBOOK
    ${odeint_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
  DEPENDS
    ${reference_xml}
)
