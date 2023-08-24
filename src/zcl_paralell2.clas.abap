CLASS zcl_paralell2 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES ty_t_time TYPE STANDARD TABLE OF cl_abap_context_info=>ty_system_time WITH DEFAULT KEY.
    INTERFACES if_abap_parallel.
    METHODS get_time RETURNING VALUE(rt_time) TYPE ty_t_time.
    METHODS get_wp_number RETURNING VALUE(rv_wp_number) TYPE char3.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gt_time_2 TYPE TABLE OF cl_abap_context_info=>ty_system_time.
    DATA gv_wp_number TYPE char3.
ENDCLASS.



CLASS ZCL_PARALELL2 IMPLEMENTATION.


  METHOD get_wp_number.
    rv_wp_number = gv_wp_number.
  ENDMETHOD.


  METHOD get_time.
    rt_time = gt_time_2.
  ENDMETHOD.


  METHOD if_abap_parallel~do.
    DO 3 TIMES.
      WAIT UP TO 2 SECONDS.
      DATA(lv_system_time) = cl_abap_context_info=>get_system_time( ).
      APPEND lv_system_time TO gt_time_2.

    ENDDO.
    gv_wp_number = '002'.
  ENDMETHOD.
ENDCLASS.
