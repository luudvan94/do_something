import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final themeData = ThemeData(
    colorScheme: _colorScheme(),
    textTheme: _textTheme(_colorScheme()),
  );

  static final darkThemeData = ThemeData(
    colorScheme: _colorScheme(brightness: Brightness.dark),
    textTheme: _textTheme(_colorScheme(brightness: Brightness.dark)),
  );

  // static function textStyle from Context
  static TextTheme textStyle(BuildContext context) {
    return Theme.of(context).textTheme;
  }

  static ColorScheme appColors(context) =>
      Theme.of(context).colorScheme; // static function appColors from Context

  static TaskColor appTaskColor(BuildContext context) {
    return TaskColor(
      background: AppTheme.appColors(context).background,
      foreground: AppTheme.appColors(context).onBackground,
    );
  }
}

extension FontWeightExtension on FontWeight {
  static const normal = FontWeight.w300;
}

TextTheme _textTheme(ColorScheme colorScheme) {
  return TextTheme(
    headlineMedium: TextStyle(
      fontSize: 30,
      fontWeight: FontWeightExtension.normal,
      color: colorScheme.onBackground,
    ),
    bodyLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeightExtension.normal,
      color: colorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeightExtension.normal,
      color: colorScheme.onBackground,
    ),
    bodySmall: TextStyle(
      fontSize: 18,
      fontWeight: FontWeightExtension.normal,
      color: colorScheme.onBackground,
    ),
  );
}

ColorScheme _colorScheme({Brightness brightness = Brightness.light}) {
  return ColorScheme(
    primary: Colors.blueGrey,
    secondary: Colors.blueGrey[200]!,
    surface: Colors.white,
    background: brightness == Brightness.light ? Colors.white : Colors.black87,
    error: Colors.red,
    onSecondary: brightness == Brightness.light ? Colors.black : Colors.white,
    onSurface: brightness == Brightness.light ? Colors.black : Colors.white,
    onPrimary: brightness == Brightness.light ? Colors.white : Colors.black,
    onBackground: brightness == Brightness.light ? Colors.black : Colors.white,
    onError: Colors.white,
    brightness: brightness,
  );
}
