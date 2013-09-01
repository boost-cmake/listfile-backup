# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

cmake_minimum_required(VERSION 2.8.10)

include(Ryppl)

ryppl_project(BoostOdeint)

ryppl_add_doc_subdirectory(doc)

ryppl_export(
  INCLUDE_DIRECTORIES
    include
)
