CLASS zexcel_itab DEFINITION
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



CLASS ZEXCEL_ITAB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "Excel to itab
    SELECT SINGLE *
    FROM zblob_test
    WHERE docnum = '1000000000'
    INTO @DATA(lw_data).

    "For flat file
*    DATA(lv_string) = xco_cp=>xstring( lw_data-attachment
*    )->as_string( xco_cp_character=>code_page->utf_8
*    )->value.

*    For excel
    TYPES:
      BEGIN OF ts_row,
        Column1 TYPE string,
        Column2 TYPE string,
      END OF ts_row,

      tt_row TYPE STANDARD TABLE OF ts_row WITH DEFAULT KEY.
    DATA:lt_rows                  TYPE tt_row.

    "Create instance of excel document based on the xstring formatted excel content
    DATA(lo_xlsx) = xco_cp_xlsx=>document->for_file_content( iv_file_content = lw_data-attachment )->read_access(  ).
    "Instance of worksheet
    DATA(lo_worksheet) = lo_xlsx->get_workbook( )->worksheet->for_name( iv_name = 'Sheet1' ).

    "Create pattern. Not specifying meaning read the whole sheet
    DATA(lo_selection_pattern) = xco_cp_xlsx_selection=>pattern_builder->simple_from_to( )->get_pattern( ).

    "Extract data and store in lt_rows
    lo_worksheet->select( lo_selection_pattern
    )->row_stream(
    )->operation->write_to( REF #( lt_rows )
    )->if_xco_xlsx_ra_operation~execute( ).

  ENDMETHOD.
ENDCLASS.
