CLASS zprint_queue DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES:
      BEGIN OF ty_shop_item,
        name      TYPE string,
        price(10) TYPE p DECIMALS 2,
      END OF ty_shop_item,

      ty_shop_item_tt TYPE STANDARD TABLE OF ty_shop_item WITH EMPTY KEY,

      BEGIN OF ty_shop,
        shop_name TYPE string,
        items     TYPE ty_shop_item_tt,
      END OF ty_shop.

    CONSTANTS:
        cns_nl   TYPE string VALUE cl_abap_char_utilities=>newline.

    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zprint_queue IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "Print queue
    DATA: lv_print_data TYPE xstring,
          lv_err_msg    TYPE string.

    SELECT * FROM zcd_test INTO TABLE @DATA(lt_table).
    CALL TRANSFORMATION id SOURCE root = lt_table RESULT XML DATA(lv_xstring).
    lv_print_data = lv_xstring.
    DATA(lv_qitem_id) = cl_print_queue_utils=>create_queue_item_by_data(
                          EXPORTING
                            iv_qname            = 'TEST_QUEUE'
                            iv_print_data       =  lv_print_data
                            iv_name_of_main_doc = 'zcd_test'
                          IMPORTING
                            ev_err_msg          = lv_err_msg
                        ).
    out->write( lv_qitem_id ).

  ENDMETHOD.
ENDCLASS.
