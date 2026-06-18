@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'List of Currency: Consumption'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_AJ_CUKIES
  provider contract transactional_query
  as projection on ZI_AJ_CUKIES
{
  key curr_uuid as CurrencyID,
      locale as Locale,
      currencyname as CurrencyName,
      description as Description,
      createdat as CreatedAt,
      createdby as CreatedBy,
      lastchangedat as LastChangedAt,
      lastchangedby as LastChandedBy,
      
      //from logic
      CurrencySymbol
}
