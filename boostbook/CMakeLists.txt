# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.8)

include(Ryppl)

ryppl_project(Boostbook
  DEPENDS
    XSLTPROC
)

ryppl_add_doc_subdirectory(doc)

if(WIN32)
  set(BOOSTBOOK_DIR "boostbook")
else(WIN32)
  set(BOOSTBOOK_DIR "share/boost/boostbook")
endif(WIN32)

set(BOOSTBOOK_DTD_DIR "${CMAKE_CURRENT_SOURCE_DIR}/dtd")
set(BOOSTBOOK_XSL_DIR "${CMAKE_CURRENT_SOURCE_DIR}/xsl")

# Find the DocBook DTD (version 4.2)
find_path(DOCBOOK_DTD_DIR docbookx.dtd PATHS
  "/opt/local/share/xml/docbook/4.2"
  "/usr/share/sgml/docbook/xml-dtd-4.2"
  "/usr/share/xml/docbook/schema/dtd/4.2"
  "/usr/share/xml/docbook/xml-dtd-4.2"
  ${CMAKE_DOCBOOK_DTD_DIR}
)
if(NOT DOCBOOK_DTD_DIR)
  message(WARNING "could not find DocBook DTD!\nSet docbook dtd directory variable: CMAKE_DOCBOOK_DTD_DIR")
endif(NOT DOCBOOK_DTD_DIR)

# Find the DocBook XSL stylesheets
find_path(DOCBOOK_XSL_DIR html/html.xsl PATHS
  "/opt/local/share/xsl/docbook-xsl"
  "/usr/share/sgml/docbook/xsl-stylesheets"
  "/usr/share/xml/docbook/*"
  "/usr/share/xml/docbook/stylesheet/nwalsh"
  ${CMAKE_DOCBOOK_XSL_DIR}
)
if(NOT DOCBOOK_XSL_DIR)
  message(WARNING "could not find DocBook XSL stylesheets!\nSet docbook xsl directory variable: CMAKE_DOCBOOK_XSL_DIR")
endif(NOT DOCBOOK_XSL_DIR)

# used in catalog.xml.in
transform_to_xml_url(XSLT_URL_PREFIX)

set(catalog "${CMAKE_CURRENT_BINARY_DIR}/catalog.xml")
configure_file(catalog.xml.in "${catalog}")

install(DIRECTORY dtd xsl
  DESTINATION "${BOOSTBOOK_DIR}"
  COMPONENT bin
  )
  
# make the binary directory usable...
file(COPY dtd xsl DESTINATION .)

set(catalog "${CMAKE_CURRENT_BINARY_DIR}/install/catalog.xml")
configure_file(catalog.xml.in "${catalog}")

install(FILES "${catalog}"
  DESTINATION "${BOOSTBOOK_DIR}"
  COMPONENT bin
  )

ryppl_export(CODE
  "set(BOOSTBOOK_CATALOG \"\${CMAKE_CURRENT_LIST_DIR}/../boostbook/catalog.xml\")\n"
  "set(BOOSTBOOK_XSL_DIR \"\${CMAKE_CURRENT_LIST_DIR}/../boostbook/xsl\")\n"
)

