INTERFACE if_icf_tree PUBLIC.
  CLASS-METHODS service_from_url
    IMPORTING
      url             TYPE string DEFAULT '/'
      hostnumber      TYPE i
      authority_check TYPE c DEFAULT 'X'
    EXPORTING
      urlsuffix       TYPE string
      icfnodguid      TYPE char25
      icf_name        TYPE char15
      icfactive       TYPE abap_bool
      icfaltnme       TYPE string
    EXCEPTIONS
      wrong_application
      no_application
      not_allow_application
      wrong_url
      no_authority.
ENDINTERFACE.