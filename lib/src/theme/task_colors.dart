import 'package:do_something/src/features/task/rating.dart';
import 'package:flutter/material.dart';

class TaskColor {
  final Color background;
  final Color foreground;

  const TaskColor({required this.background, this.foreground = Colors.white});

  static const green264653 = TaskColor(
    background: Color(0xFF264653),
  );

  static const green2a9d8f = TaskColor(
    background: Color(0xFF2a9d8f),
  );

  static const yellowe9c46a = TaskColor(
    background: Color(0xFFe9c46a),
  );

  static const orangef4a261 = TaskColor(
    background: Color(0xFFf4a261),
  );

  static const orangee76f51 = TaskColor(
    background: Color(0xFFe76f51),
  );

  static const ccd5ae = TaskColor(
    background: Color(0xFFccd5ae),
    foreground: Colors.black,
  );

  //e9edc9
  static const e9edc9 = TaskColor(
    background: Color(0xFFe9edc9),
    foreground: Colors.black,
  );

  //fefae0
  static const fefae0 = TaskColor(
    background: Color(0xFFfefae0),
    foreground: Colors.black,
  );

  //faedcd
  static const faedcd = TaskColor(
    background: Color(0xFFfaedcd),
    foreground: Colors.black,
  );

  //d4a373
  static const d4a373 = TaskColor(
    background: Color(0xFFd4a373),
    foreground: Colors.black,
  );
}

class TaskColorSet {
  final Map<Rating, TaskColor> colorRatingMap;

  const TaskColorSet({required this.colorRatingMap});

  TaskColor colorFromRating(Rating rating) {
    return colorRatingMap[rating]!;
  }

  static TaskColorSet set1 = const TaskColorSet(
    colorRatingMap: {
      Rating.veryBad: TaskColor.orangee76f51,
      Rating.bad: TaskColor.orangef4a261,
      Rating.neutral: TaskColor.yellowe9c46a,
      Rating.good: TaskColor.green2a9d8f,
      Rating.veryGood: TaskColor.green264653,
    },
  );

  static TaskColorSet set2 = const TaskColorSet(
    colorRatingMap: {
      Rating.veryBad: TaskColor.d4a373,
      Rating.bad: TaskColor.faedcd,
      Rating.neutral: TaskColor.fefae0,
      Rating.good: TaskColor.e9edc9,
      Rating.veryGood: TaskColor.ccd5ae,
    },
  );
}
