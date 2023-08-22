CLASS zabap_memory DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES: if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zabap_memory IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "ABAP memory using internal table
    TYPES:
      BEGIN OF bline,
        id    TYPE i,
        clstr TYPE x LENGTH 100,
      END OF bline.
    DATA: lt_input_b TYPE TABLE OF bline WITH EMPTY KEY,
          lt_input   TYPE STANDARD TABLE OF I_UnitOfMeasure,
          lt_output  TYPE STANDARD TABLE OF I_UnitOfMeasure.

    SELECT *  FROM I_UnitOfMeasure INTO TABLE @lt_input.
    EXPORT input = lt_input TO INTERNAL TABLE lt_input_b.
    IMPORT input = lt_output FROM INTERNAL TABLE lt_input_b.

    "ABAP memory using buffer
    DATA:buffer       TYPE xstring,
         lt_input_bf  TYPE STANDARD TABLE OF I_UnitOfMeasure,
         lt_output_bf TYPE STANDARD TABLE OF I_UnitOfMeasure.

    SELECT *  FROM I_UnitOfMeasure INTO TABLE @lt_input_bf.
    EXPORT input = lt_input_bf TO DATA BUFFER buffer.
    IMPORT input = lt_output_bf FROM DATA BUFFER buffer.

  ENDMETHOD.
ENDCLASS.
