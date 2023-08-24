CLASS zcl_zobj_cd_test_chdo DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_chdo_enhancements .

    TYPES:
      BEGIN OF ty_zcd_test .
        INCLUDE TYPE zcd_test.
        INCLUDE TYPE if_chdo_object_tools_rel=>ty_icdind.
  TYPES END OF ty_zcd_test .
    TYPES:
      tt_zcd_test TYPE STANDARD TABLE OF ty_zcd_test .

    CLASS-DATA objectclass TYPE if_chdo_object_tools_rel=>ty_cdobjectcl READ-ONLY VALUE 'ZOBJ_CD_TEST' ##NO_TEXT.

    CLASS-METHODS write
      IMPORTING
        !objectid                TYPE if_chdo_object_tools_rel=>ty_cdobjectv
        !utime                   TYPE if_chdo_object_tools_rel=>ty_cduzeit
        !udate                   TYPE if_chdo_object_tools_rel=>ty_cddatum
        !username                TYPE if_chdo_object_tools_rel=>ty_cdusername
        !planned_change_number   TYPE if_chdo_object_tools_rel=>ty_planchngnr DEFAULT space
        !object_change_indicator TYPE if_chdo_object_tools_rel=>ty_cdchngindh DEFAULT 'U'
        !planned_or_real_changes TYPE if_chdo_object_tools_rel=>ty_cdflag DEFAULT space
        !no_change_pointers      TYPE if_chdo_object_tools_rel=>ty_cdflag DEFAULT space
        !xzcd_test               TYPE tt_zcd_test OPTIONAL
        !yzcd_test               TYPE tt_zcd_test OPTIONAL
        !upd_zcd_test            TYPE if_chdo_object_tools_rel=>ty_cdchngindh DEFAULT space
      EXPORTING
        VALUE(changenumber)      TYPE if_chdo_object_tools_rel=>ty_cdchangenr
      RAISING
        cx_chdo_write_error .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ZOBJ_CD_TEST_CHDO IMPLEMENTATION.


  METHOD write.
*"----------------------------------------------------------------------
*"         this WRITE method is generated for object ZOBJ_CD_TEST
*"         never change it manually, please!        :07/31/2023
*"         All changes will be overwritten without a warning!
*"
*"         CX_CHDO_WRITE_ERROR is used for error handling
*"----------------------------------------------------------------------

    DATA: l_upd        TYPE if_chdo_object_tools_rel=>ty_cdchngind.

    CALL METHOD cl_chdo_write_tools=>changedocument_open
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        planned_change_number   = planned_change_number
        planned_or_real_changes = planned_or_real_changes.

    IF ( yzcd_test IS INITIAL ) AND
       ( xzcd_test IS INITIAL ).
      l_upd  = space.
    ELSE.
      l_upd = upd_zcd_test.
    ENDIF.

    IF l_upd NE space.
      CALL METHOD cl_chdo_write_tools=>changedocument_multiple_case
        EXPORTING
          tablename        = 'ZCD_TEST'
          change_indicator = upd_zcd_test
          docu_delete      = 'X'
          docu_insert      = 'X'
          docu_delete_if   = ''
          docu_insert_if   = ''
          table_old        = yzcd_test
          table_new        = xzcd_test.
    ENDIF.

    CALL METHOD cl_chdo_write_tools=>changedocument_close
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        date_of_change          = udate
        time_of_change          = utime
        username                = username
        object_change_indicator = object_change_indicator
        no_change_pointers      = no_change_pointers
      IMPORTING
        changenumber            = changenumber.

  ENDMETHOD.


  METHOD if_chdo_enhancements~authority_check.
    "No Auth check performed. Allow all
    rv_is_authorized = 'X'.
  ENDMETHOD.
ENDCLASS.
