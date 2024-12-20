import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_app/core/constants/app_color.dart';
import 'package:mobile_app/core/constants/app_color.dart';

ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: colorBackground,
  appBarTheme: AppBarTheme(
    backgroundColor: colorBackground,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: colorBackground,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarColor: colorBackground,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  ),
);

Color? colorCard = Colors.white24;
Color? colorBackground = TColors.primary60;