@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Genre: Consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AJ_GENRES
  provider contract transactional_query
  as projection on ZI_AJ_GENRES
{
  key Genreid,
      Locale,
      @Semantics.text: true
      GenreName,
      Description,
      CreatedAt,
      CreatedBy,
      Lastchangedat,
      Lastchangedby
} 
