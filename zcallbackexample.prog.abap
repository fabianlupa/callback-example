*&---------------------------------------------------------------------*
*& Report zcallbackexample
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcallbackexample.

CLASS lcl_callback_listener DEFINITION.
  PUBLIC SECTION.
    METHODS:
      on_pull IMPORTING iv_package TYPE devclass.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS lcl_callback_listener IMPLEMENTATION.
  METHOD on_pull.
    CALL FUNCTION 'POPUP_TO_INFORM'
      EXPORTING
        titel = sy-title
        txt1  = 'Pull'
        txt2  = '!'.
  ENDMETHOD.
ENDCLASS.
