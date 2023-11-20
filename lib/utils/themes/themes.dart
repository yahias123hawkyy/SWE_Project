
import 'package:flutter/material.dart';
import 'package:iparkmobileapplication/utils/themes/app_colors.dart';

abstract class AvailableThemes{

static ThemeData lightTheme = ThemeData(
 textTheme: TextTheme(
  titleMedium:  TextStyle(
    color: MainColors.mainLightThemeColor
  ),
  titleLarge: TextStyle(
    color: MainColors.mainLightThemeColor
  )
 ) ,
 brightness: Brightness.light,
 primaryColor: MainColors.mainLightThemeColor,
 appBarTheme: const AppBarTheme(titleTextStyle: TextStyle(
  color: Color(0xFF1B434D),
  fontSize: 17
 ),centerTitle: true,backgroundColor:Colors.white),
 elevatedButtonTheme: ElevatedButtonThemeData(style:ButtonStyle(
 backgroundColor: MaterialStateProperty.all<Color>(MainColors.mainLightThemeColor)
 ) ),
);



static ThemeData darkTheme = ThemeData(
 brightness: Brightness.dark,
 primaryColor: MainColors.mainDarkThemeColor
);

}