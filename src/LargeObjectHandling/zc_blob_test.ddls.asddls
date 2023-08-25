@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZI_BLOB_TEST'
@ObjectModel.semanticKey: [ 'Docnum' ]
define root view entity ZC_BLOB_TEST
  provider contract transactional_query
  as projection on ZI_BLOB_TEST
{
  key Docnum,
  Attachment,
  Mimetype,
  Filename,
  LocalLastChangedAt
  
}
