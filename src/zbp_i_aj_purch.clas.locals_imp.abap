CLASS lhc_ZI_AJ_PURCH DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zi_aj_purch RESULT result.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys   REQUEST requested_features
                  FOR zi_aj_purch
      RESULT    result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zi_aj_purch RESULT result.

    METHODS validatecustname FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_aj_purch~validateCustname.
    METHODS validateOverall FOR VALIDATE ON SAVE
      IMPORTING keys FOR zi_aj_purch~validateOverall.
    METHODS setOrderDefaults FOR DETERMINE ON MODIFY
      IMPORTING keys FOR zi_aj_purch~setOrderDefaults.
    METHODS ChangeStatus FOR MODIFY
      IMPORTING keys FOR ACTION zi_aj_purch~ChangeStatus RESULT result.
    METHODS ChangeStatusAutoAccept FOR MODIFY
      IMPORTING keys FOR ACTION ZI_AJ_PURCH~ChangeStatusAutoAccept RESULT result.
ENDCLASS.

CLASS lhc_ZI_AJ_PURCH IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD validatecustname.
*    SELECT * FROM zaj_tbl_cukies INTO TABLE @DATA(lt_currencies).
  ENDMETHOD.

  METHOD validateOverall.


*   Validating the quantity
    READ ENTITIES OF zi_aj_purch IN LOCAL MODE
     ENTITY zi_aj_purch
         FIELDS ( Orderid TotalItem Bookid )
         WITH CORRESPONDING #( keys )
     RESULT DATA(lt_orders)
     FAILED DATA(lt_read_failed).

    READ ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch BY \_Books
        FIELDS ( Bookid Title Stock )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_books)
        LINK DATA(lt_books_link).


    LOOP AT lt_orders INTO DATA(lw_order).

      DATA(lv_has_error) = abap_false.


      IF lw_order-TotalItem IS INITIAL.
        lv_has_error = abap_true.

        "Block the save
        APPEND VALUE #( %tky = lw_order-%tky )
            TO failed-zi_aj_purch.

        "Display message
        APPEND VALUE #(
            %tky = lw_order-%tky
            %msg = new_message_with_text(
                severity = if_abap_behv_message=>severity-error
                text = `Quantity is required to purchase this item`
            )
        )
        TO reported-zi_aj_purch.

        CONTINUE.
      ELSE.

*           Find the associated book via LINK table
        READ TABLE lt_books_link INTO DATA(lw_link)
            WITH KEY source-%tky = lw_order-%tky.
        IF sy-subrc <> 0.

          lv_has_error = abap_true.

          "Block the save
          APPEND VALUE #( %tky = lw_order-%tky )
              TO failed-zi_aj_purch.

          "Display message
          APPEND VALUE #(
             %tky = lw_order-%tky
             %msg = new_message_with_text(
                 severity = if_abap_behv_message=>severity-error
                 text = `No associated books found`
             )
         )
         TO reported-zi_aj_purch.

          CONTINUE.
        ENDIF.

*            Read the target book row

        READ TABLE lt_books INTO DATA(lw_books)
           WITH KEY %tky = lw_link-target-%tky.
        IF sy-subrc <> 0.
          lv_has_error = abap_true.

          "Block the save
          APPEND VALUE #( %tky = lw_order-%tky )
              TO failed-zi_aj_purch.

          "Display message
          APPEND VALUE #(
              %tky = lw_order-%tky
              %msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-error
                  text = `Book data could not be read`
              )
          )
          TO reported-zi_aj_purch.

          CONTINUE.

        ENDIF.


        IF lw_order-TotalItem > lw_books-Stock.

          lv_has_error = abap_true.

          "Block the save
          APPEND VALUE #( %tky = lw_order-%tky )
              TO failed-zi_aj_purch.


          "Display message
          APPEND VALUE #(
              %tky = lw_order-%tky
              %msg = new_message_with_text(
                  severity = if_abap_behv_message=>severity-error
                  text = |Only { lw_books-Stock } item(s) available for book { lw_books-Title  } |
              )
          )
          TO reported-zi_aj_purch.

          CONTINUE.


        ENDIF.



      ENDIF.


    ENDLOOP.


  ENDMETHOD.

  METHOD setOrderDefaults.

    "Read the keys of newly created instances
    READ ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch
            FIELDS ( OrderDate OrderTime DeliveryDate Status )
            WITH CORRESPONDING #( keys )
        RESULT DATA(lt_orders).

    "Only set defaults where fields are still initial
    MODIFY ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch
            UPDATE FIELDS ( OrderDate OrderTime DeliveryDate )
            WITH VALUE #(
                FOR lw_order IN lt_orders
                WHERE ( OrderDate IS INITIAL )
                (
                    %tky = lw_order-%tky
                    OrderDate = cl_abap_context_info=>get_system_date( )
                    OrderTime = cl_abap_context_info=>get_system_time( )
                    DeliveryDate = cl_abap_context_info=>get_system_date( ) + 7
                )
            )
        REPORTED DATA(lt_reported_data).

    reported = CORRESPONDING #( DEEP lt_reported_data ).

  ENDMETHOD.

  METHOD ChangeStatus.

    "Modify the status
    MODIFY ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch
        UPDATE FIELDS ( Status )
        WITH VALUE
        #( FOR key IN keys
            (
            %tky = key-%tky
            Status = 'For Delivery'
            )
        )
        REPORTED DATA(lt_reported_modify_status).

    "Read the updated data
    READ ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch
        ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(lt_orders)
        FAILED   DATA(lt_failed)
        REPORTED DATA(lt_reported_read).

    "Fill result — mandatory when result[1] $self is declared
    result = VALUE #(
        FOR lw_order IN lt_orders
        (
            %tky = lw_order-%tky
            %param = lw_order
        )
    ).

    "Send the message
*    APPEND LINES OF lt_reported_modify_status TO reported-zi_aj_purch.
*    APPEND LINES OF lt_reported_read   TO reported-zi_aj_purch.
*    failed-zi_aj_purch = lt_failed.

  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
        RESULT DATA(lt_orders)
        FAILED DATA(lt_failed).


    result = VALUE #( FOR order IN lt_orders
                      ( %tky = order-%tky
                        " Disable button when already For Delivery
                        %action-ChangeStatus =
                          COND #( WHEN order-Status = 'For Delivery'
                                  THEN if_abap_behv=>fc-o-disabled
                                  WHEN order-Status = 'Cancelled'
                                  THEN if_abap_behv=>fc-o-disabled
                                  ELSE if_abap_behv=>fc-o-enabled )
                               ) ).

  ENDMETHOD.

  METHOD ChangeStatusAutoAccept.

    MODIFY ENTITIES OF zi_aj_purch IN LOCAL MODE
        ENTITY zi_aj_purch
        UPDATE FIELDS ( Status )
        WITH VALUE
        #( FOR key IN keys
            (
            %tky = key-%tky
            Status = 'For Delivery'
            )
        )
        REPORTED DATA(lt_reported_modify_status).

  ENDMETHOD.

ENDCLASS.
