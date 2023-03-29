CLASS zcl_http_handler DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_http_extension.
  PRIVATE SECTION.
    METHODS test1 IMPORTING server TYPE REF TO if_http_server.
    METHODS test2 IMPORTING server TYPE REF TO if_http_server.
    METHODS test3 IMPORTING server TYPE REF TO if_http_server.
    METHODS test4 IMPORTING server TYPE REF TO if_http_server.
    METHODS test5 IMPORTING server TYPE REF TO if_http_server.
    METHODS test6 IMPORTING server TYPE REF TO if_http_server.
    METHODS test7 IMPORTING server TYPE REF TO if_http_server.
ENDCLASS.

CLASS zcl_http_handler IMPLEMENTATION.

  METHOD if_http_extension~handle_request.
    DATA lv_path TYPE string.
    lv_path = server->request->get_header_field( '~path' ).
    CASE lv_path.
      WHEN '/ztestabap'.
        test1( server ).
      WHEN '/ztestabap/test2'.
        test2( server ).
      WHEN '/ztestabap/test3'.
        test3( server ).
      WHEN '/ztestabap/test4'.
        test4( server ).
      WHEN '/ztestabap/test5'.
        test5( server ).
      WHEN '/ztestabap/test6'.
        test6( server ).
      WHEN '/ztestabap/test7'.
        test7( server ).
      WHEN OTHERS.
        server->response->set_content_type( 'text/plain' ).
        server->response->set_cdata( 'unknown path' ).
        server->response->set_status(
          code   = 200
          reason = 'Success' ).
    ENDCASE.
  ENDMETHOD.

  METHOD test1.
    DATA lv_path      TYPE string.
    DATA lv_path_info TYPE string.
    DATA lv_method    TYPE string.
    lv_path = server->request->get_header_field( '~path' ).
    lv_path_info = server->request->get_header_field( '~path_info' ).
    lv_method = server->request->get_method( ).
    server->response->set_content_type( 'text/plain' ).
    server->response->set_cdata( 'boo, path:' && lv_path &&
      ', method:' && lv_method &&
      ', info:' && lv_path_info ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.

  METHOD test2.
    DATA lv_path_info TYPE string.
    lv_path_info = server->request->get_header_field( '~path_info' ).
    server->response->set_header_field(
      name  = 'content-type'
      value = 'text/html' ).
    server->response->set_cdata( |<b>hello { lv_path_info }<b>| ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.

  METHOD test3.
    server->response->set_header_field(
      name  = 'cache-control'
      value = 'no-store' ).
    server->response->set_cdata( 'foo' ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.

  METHOD test4.
    DATA lv_request_uri TYPE string.
    lv_request_uri = server->request->get_header_field( '~request_uri' ).
    server->response->set_header_field(
      name  = 'content-type'
      value = 'text/plain' ).
    server->response->set_cdata( lv_request_uri ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.

  METHOD test5.
    DATA lv_path_te TYPE string.
    lv_path_te = server->request->get_header_field( '~path_translated_expanded' ).
    server->response->set_header_field(
      name  = 'content-type'
      value = 'text/plain' ).
    server->response->set_cdata( lv_path_te ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.

  METHOD test6.
    DATA lv_query_string TYPE string.
    lv_query_string = server->request->get_header_field( '~query_string' ).
    server->response->set_header_field(
      name  = 'content-type'
      value = 'text/plain' ).
    server->response->set_cdata( lv_query_string ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.

  METHOD test7.
    DATA lt_fields TYPE tihttpnvp.
    DATA ls_field  LIKE LINE OF lt_fields.
    DATA lv_text   TYPE string.

    server->request->get_form_fields( CHANGING fields = lt_fields ).
    LOOP AT lt_fields INTO ls_field.
      lv_text = |{ lv_text }{ ls_field-name }={ ls_field-value }\n|.
    ENDLOOP.

    server->request->get_form_fields_cs( CHANGING fields = lt_fields ).
    LOOP AT lt_fields INTO ls_field.
      lv_text = |{ lv_text }{ ls_field-name }={ ls_field-value }\n|.
    ENDLOOP.

    server->response->set_header_field(
      name  = 'content-type'
      value = 'text/plain' ).
    server->response->set_cdata( lv_text ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.
ENDCLASS.