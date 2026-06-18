@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Currency: Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.resultSet.sizeCategory: #XS
define root view entity ZI_AJ_CUKIES
  as select from zaj_tbl_cukies
{
  key curr_uuid,          
      locale,       
      @Semantics.text: true
      currencyname, 
      description, 
      @Semantics.systemDateTime.lastChangedAt: true  
      createdat,     
      @Semantics.user.createdBy: true
      createdby,     
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      lastchangedat,
      @Semantics.user.lastChangedBy: true 
      lastchangedby,
      
      // logics
      case currencyname 
        when 'USD' then '$'
        when 'PHP' then '₱'
        when 'JPY' then '¥'
        when 'CNY' then '¥'
        else '' 
      end as CurrencySymbol 
        

}
