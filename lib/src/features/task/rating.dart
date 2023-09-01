// colors extention based on rating
import 'package:do_something/src/theme/app_theme.dart';
import 'package:flutter/material.dart';

enum Rating { veryBad, bad, neutral, good, veryGood }

extension RatingExtension on Rating {
  Color getColorFromTheme(BuildContext context) {
    // colors based on rating
    switch (this) {
      case Rating.veryBad:
        return AppTheme.appColors(context).systemRed;
      case Rating.bad:
        return AppTheme.appColors(context).systemOrange;
      case Rating.neutral:
        return AppTheme.appColors(context).systemIndigo;
      case Rating.good:
        return AppTheme.appColors(context).systemGreen;
      case Rating.veryGood:
        return AppTheme.appColors(context).systemTeal;
    }
  }

  String toName() {
    switch (this) {
      case Rating.veryBad:
        return 'Very Bad';
      case Rating.bad:
        return 'Bad';
      case Rating.neutral:
        return 'Neutral';
      case Rating.good:
        return 'Good';
      case Rating.veryGood:
        return 'Very Good';
    }
  }

  static Rating fromName(String name) {
    switch (name) {
      case 'Very Bad':
        return Rating.veryBad;
      case 'Bad':
        return Rating.bad;
      case 'Neutral':
        return Rating.neutral;
      case 'Good':
        return Rating.good;
      case 'Very Good':
        return Rating.veryGood;
      default:
        return Rating.neutral;
    }
  }
}
