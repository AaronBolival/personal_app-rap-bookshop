@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Books: Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_AJ_PURCH
  as select from zaj_tbl_purhc
{
  key custid        as Custid,
  key bookid        as Bookid,
      custname      as Custname,
      total_item    as TotalItem,
      price         as Price,
      currency      as Currency,
      order_date    as OrderDate,
      order_time    as OrderTime,
      delivery_date as DeliveryDate,
      delivery_time as DeliveryTime,
      status        as Status,
      createdat     as Createdat,
      createdby     as Createdby,
      lastchangedat as Lastchangedat,
      lastchangedby as Lastchangedby
}
