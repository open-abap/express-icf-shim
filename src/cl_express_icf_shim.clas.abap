CLASS cl_express_icf_shim DEFINITION PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS run
      IMPORTING
        express TYPE any.
ENDCLASS.

CLASS cl_express_icf_shim IMPLEMENTATION.

  METHOD run.
    DATA lv_xstr TYPE xstring.
    DATA lv_str TYPE xstring.
    DATA lv_name TYPE string.
    DATA lv_value TYPE string.
    DATA lv_code TYPE i.
    DATA lv_classname TYPE string.
    DATA lv_content_type TYPE string.
    DATA li_handler TYPE REF TO if_http_extension.
    DATA li_server TYPE REF TO if_http_server.

    WRITE '@KERNEL lv_classname.set(INPUT.class);'.
    TRANSLATE lv_classname TO UPPER CASE.
    CREATE OBJECT li_handler TYPE (lv_classname).
    CREATE OBJECT li_server TYPE lcl_server.

    WRITE '@KERNEL lv_xstr.set(INPUT.req.body.toString("hex").toUpperCase());'.
    li_server->request->set_data( lv_xstr ).
    WRITE '@KERNEL lv_str.set(INPUT.req.method);'.
    li_server->request->set_method( lv_str ).
    WRITE '@KERNEL for (const h in INPUT.req.headers) {'.
    WRITE '@KERNEL   lv_name.set(h);'.
    WRITE '@KERNEL   lv_value.set(INPUT.req.headers[h]);'.
    li_server->request->set_header_field(
      name  = lv_name
      value = lv_value ).
    WRITE '@KERNEL }'.

* todo, req.path
* todo, req.query

********************************************************

    li_handler->handle_request( li_server ).

********************************************************

    lv_xstr = li_server->response->get_data( ).
    li_server->response->get_status( IMPORTING code = lv_code ).

    lv_content_type = li_server->response->get_content_type( ).
    WRITE '@KERNEL INPUT.res.append("Content-Type", lv_content_type.get());'.

    WRITE '@KERNEL INPUT.res.status(lv_code.get()).send(Buffer.from(lv_xstr.get(), "hex"));'.
  ENDMETHOD.

ENDCLASS.