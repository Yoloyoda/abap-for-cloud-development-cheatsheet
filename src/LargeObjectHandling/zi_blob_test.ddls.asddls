@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED Large Object Test'
define root view entity ZI_BLOB_TEST
  as select from zblob_test as BLOB_TEST
{
  key docnum                as Docnum,
      @Semantics.largeObject:
      { mimeType: 'Mimetype',
      fileName: 'Filename',
      contentDispositionPreference: #INLINE }
      attachment            as Attachment,
      @Semantics.mimeType: true
      mimetype              as Mimetype,
      filename              as Filename,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt

}
