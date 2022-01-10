CLASS cl_express_icf_shim DEFINITION PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS run
      IMPORTING express TYPE any.
ENDCLASS.

CLASS cl_express_icf_shim IMPLEMENTATION.
  METHOD run.

    DATA lv_classname TYPE string.
    DATA li_http TYPE REF TO if_http_extension.

    WRITE '@KERNEL lv_classname.set(INPUT.class);'.
    TRANSLATE lv_classname TO UPPER CASE.

    CREATE OBJECT li_http TYPE (lv_classname).

* sdf   WRITE '@KERNEL console.dir(INPUT);'.
  ENDMETHOD.
ENDCLASS.