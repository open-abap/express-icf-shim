CLASS lcl_server DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_http_server.

    ALIASES request FOR if_http_server~request.
    ALIASES response FOR if_http_server~response.
ENDCLASS.

CLASS lcl_server IMPLEMENTATION.

  METHOD if_http_server~validate_xsrf_token.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~unescape_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~set_session_stateful_via_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~set_page.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~set_compression.
* todo
    RETURN.
  ENDMETHOD.

  METHOD if_http_server~send_page.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~get_xsrf_token.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~get_location_exception.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~get_location.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~get_last_error.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~get_extension_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~get_extension_info.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~escape_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~escape_html.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~encode_base64.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~enable_foreign_session_access.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~decode_base64.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~create_rel_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~create_abs_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~append_field_url.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~logoff.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~set_session_stateful.
* todo, hmm, the node will run in one thread, always with state?
    RETURN.
  ENDMETHOD.

ENDCLASS.