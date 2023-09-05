import 'package:do_something/src/features/models/rating.dart';
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

  //e63946
  static const e63946 = TaskColor(
    background: Color(0xFFe63946),
  );

  //f1faee
  static const f1faee = TaskColor(
    background: Color(0xFFf1faee),
    foreground: Colors.black,
  );

  //a8dadc
  static const a8dadc = TaskColor(
    background: Color(0xFFa8dadc),
    foreground: Colors.black,
  );

  //457b9d
  static const blue457b9d = TaskColor(
    background: Color(0xFF457b9d),
  );

  //1d3557
  static const blue1d3557 = TaskColor(
    background: Color(0xFF1d3557),
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

  static TaskColorSet set3 = const TaskColorSet(
    colorRatingMap: {
      Rating.veryBad: TaskColor.e63946,
      Rating.bad: TaskColor.blue457b9d,
      Rating.neutral: TaskColor.blue1d3557,
      Rating.good: TaskColor.a8dadc,
      Rating.veryGood: TaskColor.f1faee,
    },
  );
}
