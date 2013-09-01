# Copyright Dave Abrahams 2012. Distributed under the Boost
# Software License, Version 1.0. (See accompanying
# file LICENSE_1_0.txt or copy at http://www.boost.org/LICENSE_1_0.txt)

include(Ryppl)
include(RypplTestSuite)

ryppl_find_and_use_package(BoostCore)
ryppl_find_and_use_package(BoostTest)
ryppl_find_and_use_package(BoostRegex)

ryppl_test_suite(
  RUN
    trim_test.cpp
    conv_test.cpp
    predicate_test.cpp
    find_test.cpp
    split_test.cpp
    join_test.cpp
    replace_test.cpp
    find_format_test.cpp
  )

ryppl_test_suite(
  RUN
    regex_test.cpp

  LINK_LIBRARIES
    boost_regex
  )