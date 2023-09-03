import 'package:do_something/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final themeData = ThemeData();

  // static function textStyle from Context
  static TextTheme textStyle(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static AppColors appColors(context) =>
      AppColors(); // static function appColors from Context
}
