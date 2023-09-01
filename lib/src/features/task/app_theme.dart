import 'package:do_something/src/features/task/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final themeData = ThemeData(
      textTheme: const TextTheme(
    headline2: TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w300,
      color: AppColors.systemWhite,
    ),
  ));
}
