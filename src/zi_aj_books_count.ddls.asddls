@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Total Counts of Books per author'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZI_AJ_BOOKS_COUNT
  as select from zaj_tbl_books as _BooksCount
{   
   key authorid as AuthorId,
    count( * ) as AuthorTotalBooks
} group by authorid
