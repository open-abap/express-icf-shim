CLASS zcl_http_handler DEFINITION PUBLIC.
  PUBLIC SECTION.
    INTERFACES if_http_extension.
ENDCLASS.

CLASS zcl_http_handler IMPLEMENTATION.
  METHOD if_http_extension~handle_request.

    server->response->set_content_type( 'application/html' ).

    server->response->set_cdata( 'boo' ).

    server->response->set_status(
      code   = 200
      reason = 'Success' ).

  ENDMETHOD.
ENDCLASS.