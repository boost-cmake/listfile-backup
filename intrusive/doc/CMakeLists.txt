# Distributed under the Boost Software License, Version 1.0.
# See http://www.boost.org/LICENSE_1_0.txt



include(Ryppl)
include(RypplDocumentation)
include(RypplQuickbook)
include(RypplDoxygen)
include(RypplAutoindex)

ryppl_find_and_use_package(Boostbook)
ryppl_find_and_use_package(Quickbook)


set(IntrusiveHeaders
  "../include/boost/intrusive/"
)

set(DoxygenParameters
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_MEMBERS=YES
  HIDE_UNDOC_CLASSES=YES
  EXTRACT_PRIVATE=NO
  ENABLE_PREPROCESSING=YES
  MACRO_EXPANSION=YES
  "PREDEFINED=\"BOOST_INTRUSIVE_DOXYGEN_INVOKED\" \\
    \"list_impl=list\" \\
    \"slist_impl=slist\" \\
    \"set_impl=set\" \\
    \"multiset_impl=multiset\" \\
    \"rbtree_impl=rbtree\" \\
    \"unordered_set_impl=unordered_set\" \\
    \"unordered_multiset_impl=unordered_multiset\" \\
    \"hashtable_impl=hashtable\" \\
    \"splay_set_impl=splay_set\" \\
    \"splay_multiset_impl=splay_multiset\" \\
    \"splaytree_impl=splaytree\" \\
    \"sg_set_impl=sg_set\" \\
    \"sg_multiset_impl=sg_multiset\" \\
    \"sgtree_impl=sgtree\" \\
    \"avl_set_impl=avl_set\" \\
    \"avl_multiset_impl=avl_multiset\" \\
    \"avltree_impl=avltree\" \\
    \"treap_set_impl=treap_set\" \\
    \"treap_multiset_impl=treap_multiset\" \\
    \"treap_impl=treap\""
)



set(autodoc_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/autodoc.xml)
ryppl_src_to_boostbook(
  INPUT
    ${IntrusiveHeaders}
  OUTPUT
    ${autodoc_bbk_xml}
  DOXYGEN_PARAMETERS
    ${DoxygenParameters}
)

set(intrusive_gen_bbk_xml ${CMAKE_CURRENT_BINARY_DIR}/intrusive_gen.xml)
quickbook_to_boostbook(
  ${CMAKE_CURRENT_SOURCE_DIR}/intrusive.qbk
  ${intrusive_gen_bbk_xml}
  INCLUDES
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${BOOST_AUTOINDEX_QBK_DIR}
)


set(HtmlParameters
  boost.root=../../../..
  boost.libraries=../../../../libs/libraries.htm
  generate.section.toc.level=3
  chunk.first.sections=1
)

set(AutoIndexParameters
  INTERNAL_INDEX
  SCRIPT
    ${CMAKE_CURRENT_SOURCE_DIR}/index.idx
  PREFIX
    ${CMAKE_CURRENT_SOURCE_DIR}/../include/
)

export_documentation(
  intrusive
  BOOSTBOOK
    ${intrusive_gen_bbk_xml}
  HTML_PARAMETERS
    ${HtmlParameters}
  AUTOINDEX_PARAMETERS
    ${AutoIndexParameters}
  DEPENDS
    ${autodoc_bbk_xml}
)
