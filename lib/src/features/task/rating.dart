// colors extention based on rating
import 'package:do_something/src/features/task/app_colors.dart';
import 'package:do_something/src/features/task/app_theme.dart';
import 'package:flutter/material.dart';

enum Rating { veryBad, bad, neutral, good, veryGood }

extension RatingColor on Rating {
  Color getColorFromTheme(BuildContext context) {
    // colors based on rating
    switch (this) {
      case Rating.veryBad:
        return AppColors.systemRed;
      case Rating.bad:
        return AppColors.systemOrange;
      case Rating.neutral:
        return AppColors.systemIndigo;
      case Rating.good:
        return AppColors.systemGreen;
      case Rating.veryGood:
        return AppColors.systemTeal;
    }
  }
}
