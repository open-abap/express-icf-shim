CLASS zcl_http_handler DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_http_extension.
ENDCLASS.

CLASS zcl_http_handler IMPLEMENTATION.
  METHOD if_http_extension~handle_request.
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