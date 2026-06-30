@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Purchases'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AJ_PURCH
  provider contract transactional_query
  as projection on ZI_AJ_PURCH
{
  key Orderid,
  key Itemno,
      Authorid,
      Custid,
      Bookid,
      BookTitle,
      Custname,
      TotalItem,
      Price,
      Currency,
      OrderDate,
      OrderTime,
      DeliveryDate,
      DeliveryTime,
      Status,
      Createdat,
      Createdby,
      Lastchangedat,
      Lastchangedby,
      ImageLink
}
