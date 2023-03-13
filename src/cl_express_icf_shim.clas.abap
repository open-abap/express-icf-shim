CLASS cl_express_icf_shim DEFINITION PUBLIC.
  PUBLIC SECTION.
    CLASS-METHODS run
      IMPORTING
        res     TYPE any
        express TYPE any.
  PRIVATE SECTION.
    CLASS-DATA mi_server TYPE REF TO if_http_server.
    CLASS-METHODS response
      IMPORTING
        res     TYPE any ##NEEDED.
ENDCLASS.

CLASS cl_express_icf_shim IMPLEMENTATION.

  METHOD run.
    DATA lv_xstr         TYPE xstring.
    DATA lv_str          TYPE string.
    DATA lv_name         TYPE string.
    DATA lv_value        TYPE string.
    DATA lv_classname    TYPE string.
    DATA li_handler      TYPE REF TO if_http_extension.

    WRITE '@KERNEL lv_classname.set(INPUT.class);'.
    TRANSLATE lv_classname TO UPPER CASE.
    CREATE OBJECT li_handler TYPE (lv_classname).

    IF mi_server IS INITIAL.
      CREATE OBJECT mi_server TYPE lcl_server.
    ENDIF.

    WRITE '@KERNEL lv_xstr.set(INPUT.req.body.toString("hex").toUpperCase());'.
    mi_server->request->set_data( lv_xstr ).
    WRITE '@KERNEL lv_str.set(INPUT.req.method);'.
    mi_server->request->set_method( lv_str ).
    WRITE '@KERNEL for (const h in INPUT.req.headers) {'.
    WRITE '@KERNEL   lv_name.set(h);'.
    WRITE '@KERNEL   lv_value.set(INPUT.req.headers[h]);'.
    mi_server->request->set_header_field(
      name  = lv_name
      value = lv_value ).
    WRITE '@KERNEL }'.

    WRITE '@KERNEL lv_value.set(INPUT.req.path);'.
    mi_server->request->set_header_field(
      name  = '~path'
      value = lv_value ).

* todo, request_uri should also include query parameters?
    mi_server->request->set_header_field(
      name  = '~request_uri'
      value = lv_value ).

* todo, req.query

********************************************************

    CREATE OBJECT mi_server->response TYPE cl_http_entity.

    li_handler->handle_request( mi_server ).

********************************************************

    response( res ).
  ENDMETHOD.

  METHOD response.
    DATA lv_code          TYPE i.
    DATA lv_xstr          TYPE xstring.
    DATA lt_header_fields TYPE tihttpnvp.
    DATA ls_field         LIKE LINE OF lt_header_fields.

    mi_server->response->get_status( IMPORTING code = lv_code ).
    IF lv_code IS INITIAL.
      lv_code = 200.
    ENDIF.

    mi_server->response->get_header_fields( CHANGING fields = lt_header_fields ).
    LOOP AT lt_header_fields INTO ls_field.
      WRITE '@KERNEL INPUT.res.append(ls_field.get().name.get(), ls_field.get().value.get());'.
    ENDLOOP.

    lv_xstr = mi_server->response->get_data( ).
    WRITE '@KERNEL INPUT.res.status(lv_code.get()).send(Buffer.from(lv_xstr.get(), "hex"));'.
  ENDMETHOD.

ENDCLASS.