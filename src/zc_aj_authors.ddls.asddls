@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Authors: Consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AJ_AUTHORS
  provider contract transactional_query
  as projection on ZI_AJ_AUTHORS
{

      key AuthorId,
      AuthorName,
      CreatedAt,
      CreatedBy,
      Lastchangedat,
      Lastchangedby,
      
      /* Association Fields */
      AuthorBooksCount,
      
      
      /* Associations */
      _Books : redirected to composition child ZC_AJ_BOOKS
}
