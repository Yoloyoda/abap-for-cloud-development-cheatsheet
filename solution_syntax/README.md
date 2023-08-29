Access complete cheatsheet [here](https://htmlpreview.github.io/?https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/solution_syntax/solution_syntax.html)
<img width="686" alt="Solution" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/9a0efbbb-7d6e-4a65-a99f-1fba596565f7">

# ABAP memory
You may use BUFFER or INTERNAL TABLE to exchange ABAP memory but former is much simpler to use. BUFFER transfers to cluster data the buffer data object which is in xstring format.
The main difference is that passing data using MEMORY ID is not supported anymore. Therefore only these 2 options are available.

Find demo objects for ABAP Memory [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zabap_memory.clas.abap)

# Access management
Note that below example demonstrates how to restrict access inside IAM app. In addition, you may choose to implement Access Control on your CDS Data Definition.
<img width="511" alt="AccessManagement" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/e01eb21e-fbc6-4dfa-9ae1-9842e4fcd439">

Similar to in SAP on-premise access management, Authorization Object and Role are still relevant in ABAP for Cloud development. The big difference is that User Profiles is not used anymore and instead, IAM App and Business Catalog are used to map Authorization Object and Business Role. User Profile is where the fine-grained access control is setup, so that some users have display access to certain table objects, while some users don’t. This is in turn done by IAM App and Access Control Object in the ABAP for Cloud development.

The actual authorization check uses the same ABAP syntax, AUTHORITY-CHECK OBJECT. This checks the authorization object and activity value, which hasn’t changed from standard ABAP.

In my below example, I created Authorization Field “ZTABLE”, Authorization Object “ZAUTH_OBJ”. In the IAM app, set the authorization object and restrict the table name and activity.
<img width="490" alt="AccessManagement1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/bd65eabd-e219-4c54-a389-460a0bfcab34">


In the Behavior Definition, implement global authorization instance. Reference [zi_blob_test.bdef](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/LargeObjectHandling/zi_blob_test.bdef.asbdef).


In the Behavior Handler class, implement the authorization check in method “get_global_authorizations”. Set a debug on this logic so that we see what is going on. Reference [zcl_blob_test.clas.locals_imp.abap](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/LargeObjectHandling/zcl_blob_test.clas.locals_imp.abap).

Now go to the Fiori application generated from the Odata service and go to the item to edit the record. The debugger should start and you can see that the result of authorization check for update(sy-subrc = 0) is OK. This is because in IAM app, 02(change) is allowed.

<img width="596" alt="AccessManagement2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/6c9ffd19-2205-4c8f-ba91-e9f032be7c9b">

Now let’s create a new record. This time, the authority check fails because IAM app does not allow 01(create).

<img width="472" alt="AccessManagement3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/46e21e86-c033-4ac3-94a2-376d3f98398f">

# Calendar
find demo object for Calendar [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zcalendar.clas.abap)

# Change document logging
1. Create a table where you want to log the document change. Create data element for the field and check on Change Document Logging.

<img width="393" alt="DocChangLog1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/c7e84dd3-4268-46ff-8a4e-3e45588a801a">

2. Create Change Document Object and set your Z table. Check how you want to log your Z table
**Log Field values for insert** – Create log entry record for each field value that’s entered.
**Log Initial values for insert** – Create log entry record for each field value even if they are empty. This created high volumn of change doucment records. Use with caution.
**Log Field values for deletion** – When object is deleted, create log entry record for each field value that’s entered.
**Log Initial values for deletion** – When object is deleted, create log entry record for each field value even if they are empty. This created high volumn of change doucment records. Use with caution.

<img width="331" alt="DocChangLog2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/6fcb3b44-4e5c-47eb-8faa-dcdece54dba0">

3. Creating change document entry. Use the generated class to write change document logging. In the below example, it’s logging update of table field

4. Reading the change document entry. In the generated class, add method implementation “if_chdo_enhancements~authority_check” and put below code inside. This method is for implementing your own autheority check, but in the below example, it is simply returning rv_is_authorized = ‘X’, meaning the authroity check is succesfull.

5. Use class method cl_chdo_read_tools=>changedocument_read to read the change log.
<img width="687" alt="DocChangLog3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/3ac58d3d-6040-4ab8-aaed-726a6cac256d">

find demo object for Change document logging [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zchange_document.clas.abap)

# Excel upload to itab
**The upload data**

<img width="125" alt="Excel1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/e1a0a6fb-ab5b-4f81-b254-6582233d71eb">

Step1. Upload excel file by RAP Odata service described in “Large object handing(storing as MIME)”. This way, the excel data is transformed to XSTRING.

Step2. Read the XSTRING to with xco_cp_xlsx. This class will read worksheet specified. Prepare an internal table that matches the file structure of excel. Use IF_XCO_XLSX_RA_WORKSHEET to select the range of the worksheet. Finally, use write_to method in if_xco_xlsx_ra_rs_operation_fc to write the values in internal table.

find demo object for Excel upload to itab [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zexcel_itab.clas.abap)

<img width="349" alt="Excel2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/6c28e8a4-c891-4598-bf43-8481405b91fb">

# Exchange rate
The released API cl_exchange_rates performs currency conversion and exchange rate update, but it does not have method to read the list of exchange rate. To workaround this, we can use standard app “Upload Business Configuration” from Fiori Launchpad. Role “SAP_CA_BC_IC_LND_PC” is required to access this, or assign role template “SAP_BR_BPC_EXPERT”.

This app is meant to maintain your custom Z customizing table but by default, SAP has generously allowed the maintenance of below standard currency tables.

<img width="590" alt="Exchange rate" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/6cd19ee4-0fbf-4e32-8212-98df532ce2f5">

# Forms and printing 
*The below setup is for Business Technology Platform. Connecting Forms Service by Adobe with ABAP Environment in S4 may require different setup.

**Preparation**

Forms Service by Adobe and Forms Service by Adobe API are required in Business Technology Platform. On the service instance of Forms Service by Adobe API, create a service key. Finally, create destination for Forms Service by Adobe instance.

<img width="461" alt="Print1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/ba6c7833-a406-41ae-b07f-eda089efc102">

**Build Form template**

Since there is no SAP Script or Smartforms, Adobe LiveCycle Designer must be used to create form layout. Follow note 2187332 to install it to your local PC.

Once the template is created, download in Adobe XML Form (*xdp), then upload this to Forms Template Store.

<img width="366" alt="Print2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/b9443030-0356-46d9-9450-cb79a3c89be5">

**Rendering Forms**

Rendering forms requies Forms Service by Adobe. Follow my blog below to set it up and consume from ABAP. https://blogs.sap.com/2022/12/14/get-started-with-forms-service-by-adobe-rest-api-in-btp/

Create client for Forms Service by Adobe template store.
```abap
mo_http_destination = cl_http_destination_provider=>create_by_cloud_destination(
  i_service_instance_name = CONV #( iv_service_instance_name )
  i_name = 'ADS_SRV'
  i_authn_mode = if_a4c_cp_service=>service_specific
  ).
mv_client = cl_web_http_client_manager=>create_by_http_destination( mo_http_destination ).
```
Render PDF by calling Forms Service by Adobe API URI “/v1/adsRender/pdf”. You can find the complete list of supported URI of this API here. https://adsrestapi-formsprocessing.cfapps.eu10.hana.ondemand.com/swagger

The rendering will return the PDF content result with base64 encoded string.

<img width="483" alt="Print3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/7e7ee6e6-78f2-4031-b913-63df5e88b83f">

**Viewing PDF**

To view the content, we must first convert base64 encoded content to xstring. Then upload this xstring as mime object in your Ztable. This Z table can be created following “Excel upload to itab” part of this blog.

```abap
"Get the base64 encoded PDF content
DATA(lo_json) = /ui2/cl_json=>generate( json = lv_rendered_pdf ).
IF lo_json IS BOUND.
  ASSIGN lo_json->* TO FIELD-SYMBOL(<data>).
  ASSIGN COMPONENT `fileContent` OF STRUCTURE <data> TO FIELD-SYMBOL(<field>).
  ASSIGN <field>->* TO FIELD-SYMBOL(<pdf_base64>).
ENDIF.

"Upload the xstring to z table, so the content can be viewed with RAP generated report
DATA: lt_input TYPE STANDARD TABLE OF zblob_test.
lt_input = VALUE #( ( docnum = '1000000001' filename = 'test.pdf' attachment = lv_pdf_xstring mimetype = 
  'application/pdf' )
  ).
INSERT zblob_test FROM TABLE @lt_input.
```
Go to the RAP service and the inserted record is disaplayed. Click on the attachment and the generated PDF from Form Service by Adobe will open.

<img width="516" alt="Print4" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/2cf2fe91-3fcb-41d9-bb1e-ffdb47ad687d">
<img width="282" alt="Print5" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/83b0ec62-f68a-465a-8459-983a737ab7bc">

find demo object for Forms and printing [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zprint_ads.clas.abap)

**Print Queue**

Create a print queue by using cl_print_queue_utils. The below examples sends data from table zcd_test and send it to print queue.

find demo object for Print Queue [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zprint_ads.clas.abap)

The print queue can be viewed in Fiori app Maintain Print Queue.

<img width="645" alt="Print6" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/bc67eeee-ac2f-45bc-8a4d-bdc8de4c006c">

If you want to integrate physical printer to ABAP Environment, follow this blog that guides you from setting up communication scnerio and installing Cloud Print Manager. https://blogs.sap.com/2017/08/07/cloud-print-manager-installation-and-configuration/

# Job scheduling
Required roles: Application Jobs(SAP_CORE_BC_APJ_JCE), Application Job Templates(SAP_CORE_BC_APJ_TPL), Maintain Job Users(SAP_CORE_BC_APJ_USR_PC)

<img width="313" alt="JobSchedule1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/ae0b2c76-1f63-4dbc-b6f0-e035aaa93177">

1. There are predefined job template to schedule your job from. If none of them meet your need, you must create your custom job template.

2. To create your custom template, first define your job entry by creating below class. This defines design time information on your job.

Refenrece class [zcl_job_schedule_apj](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zcl_job_schedule_apj.clas.abap)

3. Then create another class to create the job catalog and job template from the job you defined. Note that you need package and transport request.

Refenrece class [zcl_job_template_apj](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zcl_job_template_apj.clas.abap)

4. After successful execution, go to Fiori app maintain Application Job Template and the new job template is created.

<img width="524" alt="JobSchedule2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/1b28f40f-233f-4fb2-bbdc-70ef0762138a">

5. Use Fiori app Application jobs to create a job with the job template.

<img width="635" alt="JobSchedule3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/5d6e9a3e-4654-4e64-a31a-efac8ade930d">

6. The method if_apj_rt_exec_object~execute in class zcl_job_schedule_apjs is executed. Whatever business logic you implemented there will be processed.

7. If you want to start, change, delete jobs programmatically, use class cl_apj_rt_api.

# Large object handling
The completely guide to storing large object in database table can be found in [Streams in RAP : Uploading PDF , Excel and Other Files in RAP Application](https://blogs.sap.com/2022/08/26/streams-in-rap-uploading-pdf-excel-and-other-files-in-rap-application/)

Find demo objects for Large object handling [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/tree/main/src/LargeObjectHandling)

# Parallel processing
Find demo objects for Parallel processing [zcl_paralell1](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zcl_paralell1.clas.abap), [zcl_paralell2](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zcl_paralell2.clas.abap) and trigger class [ztrigger_parallel](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/ztrigger_parallel.clas.abap) 

# Translation
Since there is no GUI, the GUI based translation maintenance is no longer available. For this purpose, Maintain Translations app is used.

<img width="440" alt="Translation1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/8be70abd-7ac1-4ccf-a2b4-6d06252dcb82">

List of all objects that are translatable.

- Application Log Object
- Business Configuration Object
- CDS Type Definition
- Data Definition
- Data Element
- Domain
- IAM Business Catalog
- Message Class
- Metadata Extension

Define the source language and target language. Demonstrate translation for metadata extension for RAP based application.

<img width="420" alt="Translation3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/4c88837b-3ca6-44ac-a97b-01052f07759d">

XLF file is downloaded and this is the file that defines the translation. Add target translation of Japanese. Upload the same file back in the Maintain Translation app and don’t forget to publish the translation.

<img width="423" alt="Translation4" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/6045b8a6-a7ec-45fe-8c53-8e8433416747">

Start the application in Japanese and English. The field names are translated based on the uploaded XLF file.

<img width="687" alt="Translation5" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/48660049-f383-45b1-8106-6180feeb780d">
<img width="683" alt="Translation6" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/66c9569f-4c07-47b1-bda7-b837688e70ec">

# UI
**ABAP Development Tool output console**

Since there is no SAP GUI, write statement or ALV output is not possible. The easiest way in ABAP for Cloud Development is to use output console in ADT. Wrap IF_OO_ADT_CLASSRUN into your class and use it’s Write method to output data.

This output is only suited for simple string output. It is not meant only for developer, and not for generating report for business application user.
```abap
CLASS ztest_class DEFINITION
PUBLIC
FINAL
CREATE PUBLIC .
PUBLIC SECTION.
  INTERFACES: if_oo_adt_classrun.
PROTECTED SECTION.
PRIVATE SECTION.
ENDCLASS.

CLASS ztest_class IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( 'Hello world!' ).
  ENDMETHOD.
ENDCLASS.
```

**Fiori app generate by ABAP UI service**

This is the primary approach to generate UI for report applications. It is part of ABAP RAP framework and no front end development is needed to generate Fiori application. It is completely different framework from SAP GUI. Instead of creating dynpro and controlling logic in PBO, PAI, ABAP RAP uses CDS view as base and expose Odata service. Fiori launchpad consumes UI service part of Odata and generates a Fiori list report based on the data from CDS view and metadata definition of it.

Supported feature:

- List page, object page to display data
- Search, filter, variant
- CRUD operation for backend database
- Visualization(graph, chart)
- Screen logic(Validation, conversion, user event)
- Draft & Copy capabilitties
- Inline edit
- Locking mechanism

Limitation:

- All limitation with Fiori Element apply(No flexibility in UI, limitation in screen control, etc.)
- Must be deployed outside of ABAP Environment, using WebEDI such as Business Application Studio or Visual Studio.

<img width="523" alt="UI" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/08142312-4c7f-4aa4-ba85-8a51931a84b8">

**Fiori app generate by ABAP2UI5(open source)**

This is open source project that allows developer to create Fiori UI5 application with pure ABAP. It is the closest approach to built free-style UI5 application in ABAP Environment. https://github.com/abap2UI5/abap2UI5

Highlights:

- Avaialble for ABAP releases (from NW 7.02 to ABAP 2305)
- Avaialble for both ABAP for Cloud and Standard ABAP language version
- Supports Selection Screens, Tables, Lists, Popups, F4-Helps, MIME Editor, File Upload/download, Chart/Graph, Side Effects, etc..
- Supports all Fiori Elements floorplan

If you want to create more flexible UI with ABAP, consider using ABAP2UI5 instead of ABAP RAP(below is a sample UI I created with ABAP2UI5).

<img width="490" alt="UI2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/5d8708aa-63bd-4c6a-b2c2-2dab968617e7">
