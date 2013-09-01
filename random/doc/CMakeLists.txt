# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt

include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


file (GLOB RandomHeaders
  ../include/boost/random/additive_combine.hpp
  ../include/boost/random/bernoulli_distribution.hpp
  ../include/boost/random/binomial_distribution.hpp
  ../include/boost/random/cauchy_distribution.hpp
  ../include/boost/random/chi_squared_distribution.hpp
  ../include/boost/random/discard_block.hpp
  ../include/boost/random/discrete_distribution.hpp
  ../include/boost/random/exponential_distribution.hpp
  ../include/boost/random/extreme_value_distribution.hpp
  ../include/boost/random/fisher_f_distribution.hpp
  ../include/boost/random/gamma_distribution.hpp
  ../include/boost/random/geometric_distribution.hpp
  ../include/boost/random/independent_bits.hpp
  ../include/boost/random/inversive_congruential.hpp
  ../include/boost/random/lagged_fibonacci.hpp
  ../include/boost/random/linear_congruential.hpp
  ../include/boost/random/linear_feedback_shift.hpp
  ../include/boost/random/lognormal_distribution.hpp
  ../include/boost/random/mersenne_twister.hpp
  ../include/boost/random/negative_binomial_distribution.hpp
  ../include/boost/random/normal_distribution.hpp
  ../include/boost/random/piecewise_constant_distribution.hpp
  ../include/boost/random/piecewise_linear_distribution.hpp
  ../include/boost/random/poisson_distribution.hpp
  ../include/boost/random/random_device.hpp
  ../include/boost/random/random_number_generator.hpp
  ../include/boost/random/ranlux.hpp
  ../include/boost/random/seed_seq.hpp
  ../include/boost/random/shuffle_order.hpp
    # shuffle_output
  ../include/boost/random/student_t_distribution.hpp
  ../include/boost/random/subtract_with_carry.hpp
  ../include/boost/random/taus88.hpp
  ../include/boost/random/triangle_distribution.hpp
  ../include/boost/random/uniform_01.hpp
  ../include/boost/random/uniform_int_distribution.hpp
  ../include/boost/random/uniform_on_sphere.hpp
  ../include/boost/random/uniform_real_distribution.hpp
  ../include/boost/random/uniform_smallint.hpp
  ../include/boost/random/variate_generator.hpp
  ../include/boost/random/weibull_distribution.hpp
  ../include/boost/random/xor_combine.hpp
)

set(DoxygenParameters
  EXPAND_ONLY_PREDEF=YES
  HIDE_UNDOC_MEMBERS=NO
  QUIET=YES
  WARN_IF_UNDOCUMENTED=NO
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  SEARCH_INCLUDES=NO
)



set(reference_xml ${CMAKE_CURRENT_BINARY_DIR}/reference.xml)
ryppl_src_to_boostbook(
  INPUT
    ${RandomHeaders}
  OUTPUT
    ${reference_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
  DOXYFILE
    ${CMAKE_CURRENT_SOURCE_DIR}/random.doxyfile.in
  XSLT_PARAMETERS
    boost.doxygen.reftitle="Headers"
)


set(random_bbk_gen_xml ${CMAKE_CURRENT_BINARY_DIR}/random_bbk.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/random.qbk
  ${random_bbk_gen_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
)

set(HtmlParameters
  boost.root=../../../..
  chunk.section.depth=2
)


export_documentation(
  random
  BOOSTBOOK
    ${random_bbk_gen_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  DEPENDS
    ${reference_xml}
)
