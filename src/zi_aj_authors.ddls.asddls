@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Books: Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_AJ_AUTHORS
  as select from zaj_tbl_authors as _Authors
  composition[0..*] of ZI_AJ_BOOKS as _Books
  association [1..1] to ZI_AJ_BOOKS_COUNT as _TotalBooks
    on $projection.AuthorId = _TotalBooks.AuthorId
{
  key authorid     as AuthorId,
      authorname   as AuthorName,
      @Semantics.systemDateTime.lastChangedAt: true
      createdat    as CreatedAt,
      @Semantics.user.createdBy: true
      createdby    as CreatedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat as Lastchangedat,
      @Semantics.user.lastChangedBy: true
      lastchangedby as Lastchangedby,
      
      //** Asscociation Fields **//
      _TotalBooks.AuthorTotalBooks as AuthorBooksCount,
      
      //** Association **//      
      _Books,
      _TotalBooks
    

}
