CLASS lhc_blob_test DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR blob_test
        RESULT result.
ENDCLASS.

CLASS lhc_blob_test IMPLEMENTATION.
  METHOD get_global_authorizations.
    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.
*     check create authorization
      AUTHORITY-CHECK OBJECT 'ZAUTH_OBJ' ID 'ACTVT' FIELD '01'.
      result-%create = COND #( WHEN sy-subrc = 0 THEN
      if_abap_behv=>auth-allowed ELSE
      if_abap_behv=>auth-unauthorized ).
    ENDIF.

    IF requested_authorizations-%update EQ if_abap_behv=>mk-on.
*     check update authorization
      AUTHORITY-CHECK OBJECT 'ZAUTH_OBJ' ID 'ACTVT' FIELD '02'.
      result-%update = COND #( WHEN sy-subrc = 0 THEN
      if_abap_behv=>auth-allowed ELSE
      if_abap_behv=>auth-unauthorized ).
    ENDIF.
  ENDMETHOD.
ENDCLASS.
