*&---------------------------------------------------------------------*
*& Report zcallbackexample
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcallbackexample.

CLASS lcl_callback_listener DEFINITION.
  PUBLIC SECTION.
    METHODS:
*      on_after_deserialize IMPORTING iv_package TYPE devclass,
      on_before_uninstall,
      test,
      new.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_callback_listener IMPLEMENTATION.
*  METHOD on_after_deserialize.
*    CALL FUNCTION 'POPUP_TO_INFORM'
*      EXPORTING
*        titel = sy-title
*        txt1  = 'Pull'
*        txt2  = '!'.
*  ENDMETHOD.

  METHOD on_before_uninstall.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = sy-title
        txt1  = 'NO LET ME LIVE'
        txt2  = 'PLEASE!'.
  ENDMETHOD.

  METHOD test.
  ENDMETHOD.
  METHOD new.
    BREAK-POINT.
  ENDMETHOD.
ENDCLASS.
"
