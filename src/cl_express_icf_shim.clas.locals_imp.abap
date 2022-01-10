CLASS lcl_server DEFINITION.
  PUBLIC SECTION.
    INTERFACES if_http_server.
    METHODS constructor.
ENDCLASS.

CLASS lcl_server IMPLEMENTATION.
  METHOD constructor.
    CREATE OBJECT if_http_server~request TYPE cl_http_entity.
    CREATE OBJECT if_http_server~response TYPE cl_http_entity.
  ENDMETHOD.

  METHOD if_http_server~logoff.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

  METHOD if_http_server~set_session_stateful.
    ASSERT 1 = 'todo'.
  ENDMETHOD.

ENDCLASS.