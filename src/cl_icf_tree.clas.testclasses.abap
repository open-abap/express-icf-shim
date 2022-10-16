CLASS ltcl_test DEFINITION FOR TESTING RISK LEVEL HARMLESS DURATION SHORT FINAL.

  PRIVATE SECTION.
    METHODS test1 FOR TESTING RAISING cx_static_check.

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

  ENDMETHOD.

ENDCLASS.