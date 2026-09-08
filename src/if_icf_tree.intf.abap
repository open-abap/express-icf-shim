INTERFACE if_icf_tree PUBLIC.

  CLASS-METHODS service_from_url
    IMPORTING
      url             TYPE string DEFAULT '/'
      hostnumber      TYPE i
      authority_check TYPE c DEFAULT 'X'
    EXPORTING
      urlsuffix       TYPE string
      icfnodguid      TYPE char25
      icf_name        TYPE icfname
      icfactive       TYPE abap_bool
      icfaltnme       TYPE string
    EXCEPTIONS
      wrong_application
      no_application
      not_allow_application
      wrong_url
      no_authority.

  CLASS-METHODS get_info_from_serv
    IMPORTING
      icf_name   TYPE icfname
      icfparguid TYPE icfparguid
      icf_langu  TYPE sy-langu
    EXPORTING
      serv_info  TYPE ANY TABLE
      icfdocu    TYPE any
      url        TYPE string
    EXCEPTIONS
      wrong_name
      wrong_parguid
      incorrect_service
      no_authority.

  CLASS-METHODS insert_node
    IMPORTING
      icf_name    TYPE icfname
      icfaltnme   TYPE string OPTIONAL
      icfparguid  TYPE icfparguid
      icfdocu     TYPE any
      doculang    TYPE sy-langu
      icfhandlst  TYPE ANY TABLE
      package     TYPE devclass
      application TYPE string OPTIONAL
      icfserdesc  TYPE any
      icfactive   TYPE abap_bool DEFAULT abap_false
    EXPORTING
      icfnodguid  TYPE char25
    EXCEPTIONS
      empty_icf_name
      no_new_virtual_host
      special_service_error
      parent_not_existing
      enqueue_error
      node_already_existing
      empty_docu
      doculang_not_installed
      security_info_error
      user_password_error
      password_encryption_error
      invalid_url
      invalid_otr_concept
      formflg401_error
      handler_error
      transport_error
      tadir_error
      package_not_found
      wrong_application
      not_allow_application
      no_application
      invalid_icfparguid
      alt_name_invalid
      alternate_name_exist
      wrong_icf_name
      no_authority.

  CLASS-METHODS change_node
    IMPORTING
      icf_name    TYPE icfname
      icfaltnme   TYPE string OPTIONAL
      icfparguid  TYPE icfparguid
      icfdocu     TYPE any
      doculang    TYPE sy-langu
      icfhandlst  TYPE ANY TABLE
      package     TYPE devclass
      application TYPE string OPTIONAL
      icfserdesc  TYPE any
      icfactive   TYPE abap_bool DEFAULT abap_false
    EXCEPTIONS
      empty_icf_name
      no_new_virtual_host
      special_service_error
      parent_not_existing
      enqueue_error
      node_already_existing
      empty_docu
      doculang_not_installed
      security_info_error
      user_password_error
      password_encryption_error
      invalid_url
      invalid_otr_concept
      formflg401_error
      handler_error
      transport_error
      tadir_error
      package_not_found
      wrong_application
      not_allow_application
      no_application
      invalid_icfparguid
      alt_name_invalid
      alternate_name_exist
      wrong_icf_name
      no_authority.

  CLASS-METHODS delete_node
    IMPORTING
      icfparguid TYPE icfparguid
    CHANGING
      icf_name   TYPE icfname
    EXCEPTIONS
      no_virtual_host_delete
      special_service_error
      enqueue_error
      node_not_existing
      node_has_childs
      node_is_aliased
      node_not_in_original_system
      transport_error
      tadir_error
      db_error
      no_authority.

ENDINTERFACE.
