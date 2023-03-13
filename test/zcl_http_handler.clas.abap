CLASS zcl_http_handler DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_http_extension.
  PRIVATE SECTION.
    METHODS test1 IMPORTING server TYPE REF TO if_http_server.
ENDCLASS.

CLASS zcl_http_handler IMPLEMENTATION.
  METHOD if_http_extension~handle_request.
    DATA lv_path   TYPE string.
    lv_path = server->request->get_header_field( '~path' ).
    CASE lv_path.
      WHEN '/abap'.
        test1( server ).
      WHEN OTHERS.
        server->response->set_content_type( 'text/plain' ).
        server->response->set_cdata( 'unknown path' ).
        server->response->set_status(
          code   = 200
          reason = 'Success' ).
    ENDCASE.

  ENDMETHOD.

  METHOD test1.
    DATA lv_path   TYPE string.
    DATA lv_method TYPE string.
    lv_path = server->request->get_header_field( '~path' ).
    lv_method = server->request->get_method( ).
    server->response->set_content_type( 'text/plain' ).
    server->response->set_cdata( 'boo, path:' && lv_path && ', method:' && lv_method ).
    server->response->set_status(
      code   = 200
      reason = 'Success' ).
  ENDMETHOD.
ENDCLASS.