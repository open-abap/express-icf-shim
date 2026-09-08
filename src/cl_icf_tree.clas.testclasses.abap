CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    TYPES ty_string_tt TYPE STANDARD TABLE OF string WITH DEFAULT KEY.

    METHODS test1 FOR TESTING RAISING cx_static_check.
    METHODS get_info_from_serv FOR TESTING RAISING cx_static_check.
    METHODS insert_node FOR TESTING RAISING cx_static_check.
    METHODS change_node FOR TESTING RAISING cx_static_check.
    METHODS delete_node FOR TESTING RAISING cx_static_check.

ENDCLASS.

CLASS ltcl_test IMPLEMENTATION.

  METHOD test1.

    DATA lv_guid TYPE char25.

    CALL METHOD cl_icf_tree=>if_icf_tree~service_from_url
      EXPORTING
        hostnumber            = 1
      IMPORTING
        icfnodguid            = lv_guid
      EXCEPTIONS
        wrong_application     = 1
        no_application        = 2
        not_allow_application = 3
        wrong_url             = 4
        no_authority          = 5
        OTHERS                = 6.

    cl_icf_tree=>if_icf_tree~service_from_url(
      EXPORTING
        hostnumber            = 1
      IMPORTING
        icfnodguid            = lv_guid
      EXCEPTIONS
        wrong_application     = 1
        no_application        = 2
        not_allow_application = 3
        wrong_url             = 4
        no_authority          = 5
        OTHERS                = 6 ).

  ENDMETHOD.

  METHOD get_info_from_serv.

    DATA lt_serv_info TYPE ty_string_tt.
    DATA lv_icfdocu   TYPE string.
    DATA lv_url       TYPE string.

    cl_icf_tree=>if_icf_tree~get_info_from_serv(
      EXPORTING
        icf_name          = 'ZTEST'
        icfparguid        = '0000000000000000000000000'
        icf_langu         = sy-langu
      IMPORTING
        serv_info         = lt_serv_info
        icfdocu           = lv_icfdocu
        url               = lv_url
      EXCEPTIONS
        wrong_name        = 1
        wrong_parguid     = 2
        incorrect_service = 3
        no_authority      = 4
        OTHERS            = 5 ).

    cl_abap_unit_assert=>assert_subrc( ).

  ENDMETHOD.

  METHOD insert_node.

    DATA lt_icfhndlist TYPE ty_string_tt.
    DATA lv_icfdocu    TYPE string.
    DATA lv_icfserdesc TYPE string.
    DATA lv_icfnodguid TYPE char25.

    cl_icf_tree=>if_icf_tree~insert_node(
      EXPORTING
        icf_name                  = 'ZTEST'
        icfparguid                = '0000000000000000000000000'
        icfdocu                   = lv_icfdocu
        doculang                  = sy-langu
        icfhandlst                = lt_icfhndlist
        package                   = '$TMP'
        application               = space
        icfserdesc                = lv_icfserdesc
        icfactive                 = abap_true
        icfaltnme                 = 'ztest'
      IMPORTING
        icfnodguid                = lv_icfnodguid
      EXCEPTIONS
        empty_icf_name            = 1
        no_new_virtual_host       = 2
        special_service_error     = 3
        parent_not_existing       = 4
        enqueue_error             = 5
        node_already_existing     = 6
        empty_docu                = 7
        doculang_not_installed    = 8
        security_info_error       = 9
        user_password_error       = 10
        password_encryption_error = 11
        invalid_url               = 12
        invalid_otr_concept       = 13
        formflg401_error          = 14
        handler_error             = 15
        transport_error           = 16
        tadir_error               = 17
        package_not_found         = 18
        wrong_application         = 19
        not_allow_application     = 20
        no_application            = 21
        invalid_icfparguid        = 22
        alt_name_invalid          = 23
        alternate_name_exist      = 24
        wrong_icf_name            = 25
        no_authority              = 26
        OTHERS                    = 27 ).

    cl_abap_unit_assert=>assert_subrc( ).

  ENDMETHOD.

  METHOD change_node.

    DATA lt_icfhndlist TYPE ty_string_tt.
    DATA lv_icfdocu    TYPE string.
    DATA lv_icfserdesc TYPE string.

    cl_icf_tree=>if_icf_tree~change_node(
      EXPORTING
        icf_name                  = 'ZTEST'
        icfaltnme                 = 'ztest'
        icfparguid                = '0000000000000000000000000'
        icfdocu                   = lv_icfdocu
        doculang                  = sy-langu
        icfhandlst                = lt_icfhndlist
        package                   = '$TMP'
        application               = space
        icfserdesc                = lv_icfserdesc
        icfactive                 = abap_true
      EXCEPTIONS
        empty_icf_name            = 1
        no_new_virtual_host       = 2
        special_service_error     = 3
        parent_not_existing       = 4
        enqueue_error             = 5
        node_already_existing     = 6
        empty_docu                = 7
        doculang_not_installed    = 8
        security_info_error       = 9
        user_password_error       = 10
        password_encryption_error = 11
        invalid_url               = 12
        invalid_otr_concept       = 13
        formflg401_error          = 14
        handler_error             = 15
        transport_error           = 16
        tadir_error               = 17
        package_not_found         = 18
        wrong_application         = 19
        not_allow_application     = 20
        no_application            = 21
        invalid_icfparguid        = 22
        alt_name_invalid          = 23
        alternate_name_exist      = 24
        wrong_icf_name            = 25
        no_authority              = 26
        OTHERS                    = 27 ).

    cl_abap_unit_assert=>assert_subrc( ).

  ENDMETHOD.

  METHOD delete_node.

    DATA lv_icf_name TYPE icfname.

    lv_icf_name = 'ZTEST'.

    cl_icf_tree=>if_icf_tree~delete_node(
      EXPORTING
        icfparguid                  = '0000000000000000000000000'
      CHANGING
        icf_name                    = lv_icf_name
      EXCEPTIONS
        no_virtual_host_delete      = 1
        special_service_error       = 2
        enqueue_error               = 3
        node_not_existing           = 4
        node_has_childs             = 5
        node_is_aliased             = 6
        node_not_in_original_system = 7
        transport_error             = 8
        tadir_error                 = 9
        db_error                    = 10
        no_authority                = 11
        OTHERS                      = 12 ).

    cl_abap_unit_assert=>assert_subrc( ).

  ENDMETHOD.

ENDCLASS.
