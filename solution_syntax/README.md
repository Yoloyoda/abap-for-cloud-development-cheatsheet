Access complete cheatsheet [here](https://htmlpreview.github.io/?https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/solution_syntax/solution_syntax.html)
<img width="686" alt="GitImage" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/59209a39-7f93-4905-8c16-bd28688d0626">

# ABAP memory
You may use BUFFER or INTERNAL TABLE to exchange ABAP memory but former is much simpler to use. BUFFER transfers to cluster data the buffer data object which is in xstring format.
The main difference is that passing data using MEMORY ID is not supported anymore. Therefore only these 2 options are available.

Find demo program for ABAP Memory [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zabap_memory.clas.abap)

# Access management
Note that below example demonstrates how to restrict access inside IAM app. In addition, you may choose to implement Access Control on your CDS Data Definition.
<img width="511" alt="AccessManagement" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/6a77dda0-8dd6-4b7e-ada2-656b59228667">

Similar to in SAP on-premise access management, Authorization Object and Role are still relevant in ABAP for Cloud development. The big difference is that User Profiles is not used anymore and instead, IAM App and Business Catalog are used to map Authorization Object and Business Role. User Profile is where the fine-grained access control is setup, so that some users have display access to certain table objects, while some users don’t. This is in turn done by IAM App and Access Control Object in the ABAP for Cloud development.

The actual authorization check uses the same ABAP syntax, AUTHORITY-CHECK OBJECT. This checks the authorization object and activity value, which hasn’t changed from standard ABAP.

In my below example, I created Authorization Field “ZTABLE”, Authorization Object “ZAUTH_OBJ”. In the IAM app, set the authorization object and restrict the table name and activity.

<img width="490" alt="AccessManagement1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/ae3f6f02-1838-40ba-a2fa-097f30fcbc16">

In the Behavior Definition, implement global authorization instance. Reference [zi_blob_test.bdef](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/LargeObjectHandling/zi_blob_test.bdef.asbdef).


In the Behavior Handler class, implement the authorization check in method “get_global_authorizations”. Set a debug on this logic so that we see what is going on. Reference [zcl_blob_test.clas.locals_imp.abap](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/LargeObjectHandling/zcl_blob_test.clas.locals_imp.abap).

Now go to the Fiori application generated from the Odata service and go to the item to edit the record. The debugger should start and you can see that the result of authorization check for update(sy-subrc = 0) is OK. This is because in IAM app, 02(change) is allowed.

<img width="596" alt="AccessManagement2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/cdaec642-980b-4c4c-b5de-490eed239a5e">

Now let’s create a new record. This time, the authority check fails because IAM app does not allow 01(create).

<img width="472" alt="AccessManagement3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/c4854395-c6a7-4198-821e-bb5528119056">

# Calendar
Find demo program for Calendar [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zcalendar.clas.abap)

# Change document logging
1. Create a table where you want to log the document change. Create data element for the field and check on Change Document Logging.

<img width="393" alt="DocChangLog1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/1f1dc23a-f146-458d-815f-03427d202f25">

2. Create Change Document Object and set your Z table. Check how you want to log your Z table
**Log Field values for insert** – Create log entry record for each field value that’s entered.
**Log Initial values for insert** – Create log entry record for each field value even if they are empty. This created high volumn of change doucment records. Use with caution.
**Log Field values for deletion** – When object is deleted, create log entry record for each field value that’s entered.
**Log Initial values for deletion** – When object is deleted, create log entry record for each field value even if they are empty. This created high volumn of change doucment records. Use with caution.

<img width="331" alt="DocChangLog2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/1e30dccd-3a9a-41da-a7a8-fbc73270eb97">

3. Creating change document entry. Use the generated class to write change document logging. In the below example, it’s logging update of table field

4. Reading the change document entry. In the generated class, add method implementation “if_chdo_enhancements~authority_check” and put below code inside. This method is for implementing your own autheority check, but in the below example, it is simply returning rv_is_authorized = ‘X’, meaning the authroity check is succesfull.

5. Use class method cl_chdo_read_tools=>changedocument_read to read the change log.
<img width="687" alt="DocChangLog3" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/5f67afbe-fe9f-47c4-bb32-97ae3fa1d6df">


Find demo program for Change document logging [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zchange_document.clas.abap)

# Excel upload to itab
**The upload data**

<img width="125" alt="Excel1" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/ca0e61bd-0c3f-494c-b267-34ebfdaddc3a">

Step1. Upload excel file by RAP Odata service described in “Large object handing(storing as MIME)”. This way, the excel data is transformed to XSTRING.

Step2. Read the XSTRING to with xco_cp_xlsx. This class will read worksheet specified. Prepare an internal table that matches the file structure of excel. Use IF_XCO_XLSX_RA_WORKSHEET to select the range of the worksheet. Finally, use write_to method in if_xco_xlsx_ra_rs_operation_fc to write the values in internal table.

Find demo program for Excel upload to itab [here](https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/blob/main/src/zexcel_itab.clas.abap)
<img width="349" alt="Excel2" src="https://github.com/Yoloyoda/abap-for-cloud-development-cheatsheet/assets/49046663/82427493-5541-4d2f-b9ab-04f01159bc4d">

