CLASS cl_express_icf_shim DEFINITION PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS run
      IMPORTING
        express TYPE any.
ENDCLASS.

CLASS cl_express_icf_shim IMPLEMENTATION.

  METHOD run.
    DATA lv_classname TYPE string.
    DATA li_handler TYPE REF TO if_http_extension.
    DATA li_server TYPE REF TO if_http_server.

    WRITE '@KERNEL lv_classname.set(INPUT.class);'.
    TRANSLATE lv_classname TO UPPER CASE.

    CREATE OBJECT li_handler TYPE (lv_classname).
    WRITE '@KERNEL console.dir(li_handler);'.

    CREATE OBJECT li_server TYPE lcl_server.
    li_handler->handle_request( li_server ).

    WRITE '@KERNEL INPUT.res.status(200).send("moo");'.
  ENDMETHOD.

ENDCLASS.