CLASS zchange_document DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zchange_document IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    "Change document
    DATA:lt_xzcd_test TYPE zcl_zobj_cd_test_chdo=>tt_zcd_test,
         lt_yzcd_test TYPE zcl_zobj_cd_test_chdo=>tt_zcd_test,
         lv_username  TYPE if_chdo_object_tools_rel=>ty_cdusername.

    DATA(lv_sys_datum) = cl_abap_context_info=>get_system_date( ).
    DATA(lv_sys_time) = cl_abap_context_info=>get_system_time( ).
    DATA(lv_user) = cl_abap_context_info=>get_user_formatted_name( ).
    lv_username = lv_user.

    APPEND INITIAL LINE TO lt_xzcd_test ASSIGNING FIELD-SYMBOL(<lw_xzcd_test>).
    <lw_xzcd_test>-employeeid = '0000000001'.
    <lw_xzcd_test>-role = 'Developer'. "New value
    APPEND INITIAL LINE TO lt_yzcd_test ASSIGNING FIELD-SYMBOL(<lw_yzcd_test>).
    <lw_yzcd_test>-employeeid = '0000000001'.
    <lw_yzcd_test>-role = 'Solution designer'. "Old value

    zcl_zobj_cd_test_chdo=>write(
      EXPORTING
        objectid                = 'ZOBJ_CD_TEST'
        utime                   = lv_sys_time
        udate                   = lv_sys_datum
        username                = lv_username
*      planned_change_number   =
        object_change_indicator = 'U'
*      planned_or_real_changes =
*      no_change_pointers      =
      xzcd_test               = lt_xzcd_test
      yzcd_test               = lt_yzcd_test
      upd_zcd_test            = 'U'
    IMPORTING
      changenumber            = DATA(lv_changenumbner)
    ).

    cl_chdo_read_tools=>changedocument_read(
      EXPORTING
        i_objectclass    = 'ZOBJ_CD_TEST'
      IMPORTING
        et_cdredadd_tab  = DATA(lt_cdredadd_tab)
    ).

  ENDMETHOD.
ENDCLASS.
