// colors extention based on rating
import 'package:do_something/src/features/task/app_theme.dart';
import 'package:flutter/material.dart';

enum Rating { veryBad, bad, neutral, good, veryGood }

extension RatingColor on Rating {
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
}
