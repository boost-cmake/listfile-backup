# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/asio.qbk
  asio_qbk.xml
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set (HtmlParameters
  boost.defaults=Boost
  chapter.autolabel=0
  chunk.section.depth=8
  chunk.first.sections=1
  toc.section.depth=2
  toc.max.depth=1
  generate.section.toc.level=1
  generate.toc="chapter nop section nop"
  root.filename=boost_asio
)

export_documentation(
  asio
  BOOSTBOOK
    ${CMAKE_CURRENT_BINARY_DIR}/asio_qbk.xml
  HTML_PARAMETERS
    ${HtmlParameters}
)




if (0)

install(
  DIRECTORY
    ${html_dir}
  DESTINATION
    share/doc

  PATTERN "*.manifest" EXCLUDE
)

set(IMG_ROOT ${CMAKE_CURRENT_SOURCE_DIR}/overview)

install(
  FILES
    ${IMG_ROOT}/async_op1.png
    ${IMG_ROOT}/async_op2.png
    ${IMG_ROOT}/proactor.png
    ${IMG_ROOT}/sync_op.png
  DESTINATION
    share/doc/html/boost_asio
)
endif(
)