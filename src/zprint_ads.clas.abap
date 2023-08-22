CLASS zprint_ads DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS:
        cns_nl   TYPE string VALUE cl_abap_char_utilities=>newline.

    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zprint_ads IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    "Print with ADS
    TRY.
        "Initialize Template Store Client
        DATA(lo_client) = NEW zcl_fp_client(
          iv_name = 'ADS_SRV'
        ).

        "create xml string
        DATA(lv_xml_raw) = |<form1>| &&
                           |<InvoiceNumber>Ego ille</InvoiceNumber>| &&
                           |<InvoiceDate>20040606T101010</InvoiceDate>| &&
                           |<OrderNumber>Si manu vacuas</OrderNumber>| &&
                           |<Terms>Apros tres et quidem</Terms>| &&
                           |<Company>| && 'My company ABCDE' && |</Company>| &&
                           |<Address>| && '1234 Ice cream street' && |</Address>| &&
                           |<StateProvince>| && 'Alaska' && |</StateProvince>| &&
                           |<ZipCode>Am undique</ZipCode>| &&
                           |<Phone>| && '1234567' && |</Phone>| &&
                           |<Fax>Vale</Fax>| &&
                           |<ContactName>Ego ille</ContactName>| &&
                           |<Item>| && 'ICE111' && |</Item>| &&
                           |<Description>| && 'Vanilla ice cream' && |</Description>| &&
                           |<Quantity>| && '1' && |</Quantity>| &&
                           |<UnitPrice>| && '10' && |</UnitPrice>| &&
                           |<Amount>| && '10' && |</Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Item></Item>| && |<Description></Description>| && |<Quantity></Quantity>| && |<UnitPrice></UnitPrice>| && |<Amount></Amount>| &&
                           |<Subtotal></Subtotal>| &&
                           |<StateTaxRate></StateTaxRate>| &&
                           |<StateTax></StateTax>| &&
                           |<FederalTaxRate></FederalTaxRate>| &&
                           |<FederalTaxRate></FederalTaxRate>| &&
                           |<FederalTax></FederalTax>| &&
                           |<ShippingCharge></ShippingCharge>| &&
                           |<GrandTotal></GrandTotal>| &&
                           |<Comments></Comments>| &&
                           |<AmountPaid></AmountPaid>| &&
                           |<DateReceived></DateReceived>| &&
                           |</form1>|.
        DATA(lv_xml) = cl_web_http_utility=>encode_base64( lv_xml_raw ).


        "Render PDF by caling REST API
        DATA(lv_rendered_pdf) = lo_client->reder_pdf( iv_xml = lv_xml ).

        "Get the base64 encoded PDF content
        DATA(lo_json) = /ui2/cl_json=>generate( json = lv_rendered_pdf ).
        IF lo_json IS BOUND.
          ASSIGN lo_json->* TO FIELD-SYMBOL(<data>).
          ASSIGN COMPONENT `fileContent` OF STRUCTURE <data> TO FIELD-SYMBOL(<field>).
          ASSIGN <field>->* TO FIELD-SYMBOL(<pdf_base64>).
        ENDIF.
    ENDTRY.

    "Convert base64 to xstring
    DATA(lv_pdf_xstring) = xco_cp=>string( <pdf_base64>
      )->as_xstring( xco_cp_binary=>text_encoding->base64
      )->value.

    "Upload the xstring to z table, so the content can be viewed with RAP generated report
    DATA: lt_input TYPE STANDARD TABLE OF zblob_test.
    lt_input = VALUE #( ( docnum = '1000000001' filename = 'test.pdf' attachment = lv_pdf_xstring mimetype = 'application/pdf' )
                           ).
    INSERT zblob_test FROM TABLE @lt_input.

  ENDMETHOD.
ENDCLASS.
