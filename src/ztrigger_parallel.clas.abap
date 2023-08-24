CLASS ztrigger_parallel DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.
  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS ztrigger_parallel IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(lo_parallel) = NEW cl_abap_parallel( ).
    DATA(lo_instance_1) = NEW zcl_paralell1( ).
    DATA(lo_instance_2) = NEW zcl_paralell2( ).

    lo_parallel->run_inst(
      EXPORTING
        p_in_tab = VALUE #( ( lo_instance_1 ) ( lo_instance_2 ) )
      IMPORTING
        p_out_tab = DATA(lt_out_tab)
      ).

    LOOP AT lt_out_tab ASSIGNING FIELD-SYMBOL(<ls_out_tab>).
      IF <ls_out_tab>-inst IS INSTANCE OF zcl_paralell1.
        lo_instance_1 = CAST #( <ls_out_tab>-inst ).
        out->write( 'System time for instance 1:' ).
        LOOP AT lo_instance_1->get_time( ) ASSIGNING FIELD-SYMBOL(<lv_instance_1>).
          out->write( <lv_instance_1> ).
        ENDLOOP.
        out->write( |WP number: { lo_instance_1->get_wp_number( ) }| ).
      ENDIF.
      IF <ls_out_tab>-inst IS INSTANCE OF zcl_paralell2.
        lo_instance_2 = CAST #( <ls_out_tab>-inst ).
        out->write( 'System time for instance 2:' ).
        LOOP AT lo_instance_2->get_time( ) ASSIGNING FIELD-SYMBOL(<lv_instance_2>).
          out->write( <lv_instance_2> ).
        ENDLOOP.
        out->write( |WP number: { lo_instance_2->get_wp_number( ) }| ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
