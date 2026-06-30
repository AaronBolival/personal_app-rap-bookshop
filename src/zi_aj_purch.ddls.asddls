@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Books: Interface'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_AJ_PURCH
  as select from zaj_tbl_purhc
  association[1..1] to ZI_AJ_BOOKS as _Books
    on $projection.Bookid = _Books.Bookid
   and $projection.Authorid = _Books.Authorid
{
  key orderid       as Orderid,
  key itemno        as Itemno,
      authorid      as Authorid,
      custid        as Custid,
      bookid        as Bookid,
      _Books.Title  as BookTitle,
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
      lastchangedby as Lastchangedby,
      
      _Books.ImgLink as ImageLink,
      
      /* Association */
      _Books
}
