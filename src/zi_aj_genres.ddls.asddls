@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Genre: Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define root view entity ZI_AJ_GENRES 
  as select from zaj_tbl_genres
{
  key genreid       as Genreid,
      locale        as Locale,
      @Semantics.text: true
      genre_name    as GenreName,
      description   as Description,
      @Semantics.systemDateTime.lastChangedAt: true
      createdat     as CreatedAt,
      @Semantics.user.createdBy: true
      createdby     as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat as Lastchangedat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby
}
