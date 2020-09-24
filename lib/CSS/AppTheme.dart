import 'package:flutter/material.dart';
import './Colors.dart';

final ThemeData epnAppTheme = buildTheme();

ThemeData buildTheme() {
  final ThemeData base = ThemeData.light();

  return base.copyWith(
      cardColor: whiteColor,
      buttonColor: btnColorBlue,
      scaffoldBackgroundColor: themebkgColor,
      accentColor: textPrimaryColor,
      errorColor: dangerColor,
      primaryColor: textPrimaryColor,
      secondaryHeaderColor: textPrimaryColor,
      primaryTextTheme: TextTheme(

        headline6: TextStyle(
          color: textPrimaryColor,
          fontFamily: 'Roboto',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        )
      ),
      appBarTheme: AppBarTheme(color: themebkgColor, elevation: 2.0),
      
      );

}
