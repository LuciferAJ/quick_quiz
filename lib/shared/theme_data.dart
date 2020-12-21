import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quick_quiz/shared/theme_colors.dart';

ThemeData quizAppTheme = ThemeData(
    fontFamily: GoogleFonts.poppins().fontFamily,
    backgroundColor: primaryColor,
    primaryColor: primaryColor,
    primaryTextTheme: TextTheme(
        headline1: TextStyle(
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        )) ,
    iconTheme: IconThemeData(
      color: secondaryColor,
    ),
    accentColor: accentColor,
    appBarTheme: AppBarTheme(
      color: primaryColor,
      actionsIconTheme: IconThemeData(
        color: Colors.white,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
    ),
    buttonColor: accentColor,
    buttonTheme: ButtonThemeData(
      buttonColor: accentColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      textTheme: ButtonTextTheme.primary,
      splashColor: Colors.deepOrange,
    ),
    textTheme: TextTheme(
        headline1: TextStyle(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.bold,
    )));
