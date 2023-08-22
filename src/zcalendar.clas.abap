CLASS zcalendar DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcalendar IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "Factory Canlendar
    "Add 2 days from a date considering factory calendar
    DATA(lo_factorycalendar) = cl_fhc_calendar_runtime=>create_factorycalendar_runtime( iv_factorycalendar_id = 'SAP_CA' ). "Canada
    lo_factorycalendar->add_workingdays_to_date(
      EXPORTING
        iv_start                 = '20221230'
        iv_number_of_workingdays = 2
      RECEIVING
        rv_end                   = DATA(lv_end) "Result is 20230103
    ).

    " Holiday Canlendar
    DATA(lo_holidaycalendar) = cl_fhc_calendar_runtime=>create_holidaycalendar_runtime(
      EXPORTING
        iv_holidaycalendar_id = 'SAP_CA' ). "Canada

    "Check if the data is a holiday in Canada
    lo_holidaycalendar->is_holiday(
      EXPORTING
        iv_date    = '20230101'
        RECEIVING
          rv_holiday = DATA(lv_result)
    ).

    "Get holiday information for 20230101
    DATA: lv_date                   TYPE lo_holidaycalendar->ty_fhc_date VALUE '20230101'.
    DATA(lo_holidays) = lo_holidaycalendar->get_holiday(
      EXPORTING
        iv_date            = lv_date
    ).

    lo_holidays->get_text(
      EXPORTING
        iv_language = sy-langu
      RECEIVING
        rs_text     = DATA(ls_text)
    ).

  ENDMETHOD.
ENDCLASS.
