@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Books: Interface'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_AJ_BOOKS
  as select from zaj_tbl_books as _Books
  association to parent ZI_AJ_AUTHORS as _Authors
    on $projection.Authorid = _Authors.AuthorId
  association [1..1] to ZI_AJ_GENRES as _Genres
    on $projection.Genreid = _Genres.Genreid
  association [0..1] to ZI_AJ_CUKIES as _Cukies
    on $projection.Currency = _Cukies.currencyname
   and _Cukies.locale = 'EN'
{
  key bookid        as Bookid,
  key authorid      as Authorid,
      genreid       as Genreid,
      _Authors.AuthorName as AuthorName,
      title         as Title,
      description   as Description,
      stock         as Stock,
      price         as Price,
      currency      as Currency,
      img_link      as ImgLink,
      book_sold     as BookSold,
      featured      as Featured,
      @Semantics.systemDateTime.lastChangedAt: true
      createdat     as CreatedAt,
      @Semantics.user.createdBy: true
      createdby     as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat as Lastchangedat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      
      //"
      _Cukies.CurrencySymbol as CurrencySymbol,
      
       //** Association **//
      _Authors,
      _Genres,
      _Cukies
}
