@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Books : Consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZC_AJ_BOOKS
  as projection on ZI_AJ_BOOKS
{
  key Bookid,
  key Authorid,
      @ObjectModel.text.element: ['GenreName']
      Genreid,
      _Genres.GenreName,
      Title,
      Description,
      Stock,
      Price,
      Currency,
      CurrencySymbol,
      ImgLink,
      BookSold,
      Featured,
      CreatedAt,
      CreatedBy,
      Lastchangedat,
      Lastchangedby,
      /* Associations */
      _Authors : redirected to parent ZC_AJ_AUTHORS
}
