CLASS zcl_job_template_apj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_JOB_TEMPLATE_APJ IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA(lo_apj_create) = cl_apj_dt_create_content=>get_instance( ).
    " Create job catalog
    lo_apj_create->create_job_cat_entry(
        iv_catalog_name       = 'Z_TESTJOB_CATALOG'
        iv_class_name         = 'zcl_job_schedule_apj'
        iv_text               = 'Job catalog text'
        iv_catalog_entry_type = cl_apj_dt_create_content=>class_based
        iv_transport_request  = 'H01K900008'
        iv_package            = 'ZSANDBOX'
    ).
    out->write( |Job catalog entry created successfully| ).

    " Create job template
    DATA lt_parameters TYPE if_apj_dt_exec_object=>tt_templ_val.

    NEW zcl_job_schedule_apj( )->if_apj_dt_exec_object~get_parameters(
      IMPORTING
        et_parameter_val = lt_parameters
    ).

    lo_apj_create->create_job_template_entry(
        iv_template_name     = 'Z_TESTJOB_TEMPLATE'
        iv_catalog_name      = 'Z_TESTJOB_CATALOG'
        iv_text              = 'Job template text'
        it_parameters        = lt_parameters
        iv_transport_request = 'H01K900008'
        iv_package           = 'ZSANDBOX'
    ).
    out->write( |Job template created successfully| ).

  ENDMETHOD.
ENDCLASS.
