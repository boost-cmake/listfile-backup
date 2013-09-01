# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.10)

include(Ryppl)

ryppl_project(BoostBuild
  DEPENDS
    BISON
)

ryppl_add_doc_subdirectory(v2/doc)

#find_package(BISON REQUIRED)

include_directories(BEFORE
  ${BoostBuild_BINARY_DIR}
  ${BoostBuild_SOURCE_DIR}/v2/engine
  )

add_executable(mkjambase
  v2/engine/mkjambase.c
  )

add_custom_command(
  OUTPUT
    ${BoostBuild_BINARY_DIR}/jambase.c
  COMMAND
    $<TARGET_FILE:mkjambase>
    ${BoostBuild_BINARY_DIR}/jambase.c
    ${BoostBuild_SOURCE_DIR}/v2/engine/Jambase
  DEPENDS
    ${BoostBuild_SOURCE_DIR}/v2/engine/Jambase
  )

add_executable(yyacc
  v2/engine/yyacc.c
  )

add_custom_command(
  OUTPUT
    ${BoostBuild_BINARY_DIR}/jamgram.y
    ${BoostBuild_BINARY_DIR}/jamgramtab.h
  COMMAND
    $<TARGET_FILE:yyacc>
    ${BoostBuild_BINARY_DIR}/jamgram.y
    ${BoostBuild_BINARY_DIR}/jamgramtab.h
    ${BoostBuild_SOURCE_DIR}/v2/engine/jamgram.yy
  DEPENDS
    ${BoostBuild_SOURCE_DIR}/v2/engine/jamgram.yy
  )

bison_target(bjam_yy
  ${BoostBuild_BINARY_DIR}/jamgram.y
  ${BoostBuild_BINARY_DIR}/jamgram.c
  )

set(bjam_src
  v2/engine/command.c
  v2/engine/compile.c
  v2/engine/constants.c
  v2/engine/debug.c
  v2/engine/function.c
  v2/engine/glob.c
  v2/engine/hash.c
  v2/engine/hdrmacro.c
  v2/engine/headers.c
  v2/engine/jam.c
  ${BoostBuild_BINARY_DIR}/jambase.c
  ${BoostBuild_BINARY_DIR}/jamgram.c
  v2/engine/lists.c
  v2/engine/make.c
  v2/engine/make1.c
  v2/engine/object.c
  v2/engine/option.c
  v2/engine/output.c
  v2/engine/parse.c
  v2/engine/pathunix.c
  v2/engine/regexp.c
  v2/engine/rules.c
  v2/engine/scan.c
  v2/engine/search.c
  v2/engine/subst.c
  v2/engine/timestamp.c
  v2/engine/variable.c
  v2/engine/modules.c
  v2/engine/strings.c
  v2/engine/filesys.c
  v2/engine/builtins.c
  v2/engine/pwd.c
  v2/engine/class.c
  v2/engine/native.c
  v2/engine/md5.c
  v2/engine/w32_getreg.c
  v2/engine/modules/set.c
  v2/engine/modules/path.c
  v2/engine/modules/regex.c
  v2/engine/modules/property-set.c
  v2/engine/modules/sequence.c
  v2/engine/modules/order.c
  )

if(WIN32)
  # copied from v2/engine/build.bat
  add_definitions(-DNT)
  list(APPEND bjam_src
    v2/engine/execnt.c
    v2/engine/filent.c
    )
else()
  list(APPEND bjam_src
    v2/engine/execunix.c
    v2/engine/fileunix.c
    )
endif()

add_executable(bjam ${bjam_src})

install(TARGETS bjam
  RUNTIME DESTINATION bin
  )

install(DIRECTORY v2/build/ v2/contrib v2/kernel v2/options v2/tools v2/util
  DESTINATION share/boost-build
  )

include(CPack)
