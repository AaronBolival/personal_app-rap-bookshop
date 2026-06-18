CLASS lhc_ZI_AJ_CUKIES DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_aj_cukies RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_aj_cukies RESULT result.
    METHODS allowedcurrencies FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_aj_cukies~allowedcurrencies.

ENDCLASS.

CLASS lhc_ZI_AJ_CUKIES IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD allowedCurrencies.

    DATA: lt_faield TYPE TABLE OF zi_aj_cukies.


    READ ENTITIES OF zi_aj_cukies IN LOCAL MODE
    ENTITY CurrencyBDEF
    FIELDS
    ( currencyname ) WITH CORRESPONDING #( keys )
    RESULT DATA(currencybdefname)
    FAILED DATA(currencybdefname_failed)
    REPORTED DATA(currencybdefname_report).

    LOOP AT currencybdefname INTO DATA(ls_currency_message)
        WHERE currencyname <> 'USD'
          AND currencyname <> 'PHP'
          AND currencyname <> 'JPY'
          AND currencyname <> 'CNY'.
*
*          APPEND VALUE #( %tky = ls_currency_message-%tky ) TO failed-currencybdef.
*          APPEND VALUE #( %tky = ls_currency_message-%tky
*                          %msg = new_message_with_text (
*                          if_abap_behv_message=>severity-error
*                          textid  = 'Currency Name is not Allowed' ) )
*          TO REPORTED-currencybdef.



    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
