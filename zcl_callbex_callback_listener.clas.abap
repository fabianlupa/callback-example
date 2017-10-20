"! abapGit callback listener
CLASS zcl_callbex_callback_listener DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS:
      on_after_pull IMPORTING iv_package     TYPE devclass
                              iv_old_version TYPE string
                              iv_new_version TYPE string,
      on_after_install.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-METHODS:
      do_the_migration.
ENDCLASS.



CLASS zcl_callbex_callback_listener IMPLEMENTATION.
  METHOD on_after_pull.
    DATA(lo_version_0dot2) = zcl_callbex_version=>of( '0.2.0' ).

    TRY.
        DATA(lo_old_version) = zcl_callbex_version=>of( iv_old_version ).
        DATA(lo_new_version) = zcl_callbex_version=>of( iv_new_version ).
      CATCH zcx_callbex_illegal_argument INTO DATA(lx_ex).
        " Version format is invalid.
        ##TODO. " Somehow inform abapGit of this error
        RETURN.
    ENDTRY.

    " Check if upgrading
    IF lo_old_version->compare_to( lo_new_version ) < 0.
      " When updating to v0.2.0 a database table migration is needed
      IF lo_old_version->compare_to( lo_version_0dot2 ) < 0 AND
         lo_new_version->compare_to( lo_version_0dot2 ) >= 0.
        do_the_migration( ).
      ENDIF.
    ENDIF.

  ENDMETHOD.

  METHOD on_after_install.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = 'Installation complete!'
        txt1  = 'Installation complete!'
        txt2  = space.
  ENDMETHOD.

  METHOD do_the_migration.
    SELECT COUNT(*) FROM zcallbex_taold.
    DATA(lv_old_count) = sy-dbcnt.

    SELECT COUNT(*) FROM zcallbex_tanew.
    DATA(lv_new_count) = sy-dbcnt.

    IF lv_old_count > 0 AND lv_new_count = 0.
      SELECT * FROM zcallbex_taold INTO TABLE @DATA(lt_old).
      INSERT zcallbex_tanew FROM TABLE @lt_old.
      DELETE zcallbex_taold FROM TABLE @lt_old.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
