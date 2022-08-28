import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class MyTheme {
  MyTheme._();

  static final ThemeData light = ThemeData(
    fontFamily: "Poppins",
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.transparent,
    ),
    textSelectionTheme:const TextSelectionThemeData(cursorColor: ColorPlate.primaryLightBG),
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      contentPadding: const EdgeInsets.only(left: 10.0, top: 0.0, bottom: 0.0),
      hintStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color.fromRGBO(170, 171, 174, 1)),
      labelStyle: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: const Color.fromRGBO(170, 171, 174, 1)),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color.fromRGBO(225, 226, 229, 1),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color.fromRGBO(51, 51, 51, 1),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.grey[200])
       )
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(ColorPlate.yellow70),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        foregroundColor: MaterialStateProperty.all(Colors.black),),
  ));


  static final ThemeData dark = ThemeData();
}
