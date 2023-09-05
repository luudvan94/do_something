// colors extention based on rating
import 'package:do_something/src/theme/task_colors.dart';
import 'package:flutter/material.dart';

enum Rating { veryBad, bad, neutral, good, veryGood }

//TODO: create a separate color set for task
extension RatingExtension on Rating {
  int difficulty() {
    switch (this) {
      case Rating.veryBad:
        return 5;
      case Rating.bad:
        return 4;
      case Rating.neutral:
        return 3;
      case Rating.good:
        return 2;
      case Rating.veryGood:
        return 1;
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

  String toEmoji() {
    switch (this) {
      case Rating.veryBad:
        return '😭';
      case Rating.bad:
        return '😞';
      case Rating.neutral:
        return '😐';
      case Rating.good:
        return '😊';
      case Rating.veryGood:
        return '😁';
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

  static List<IdentifiableRating> identifiableRatings() {
    return [
      IdentifiableRating(Rating.veryBad),
      IdentifiableRating(Rating.bad),
      IdentifiableRating(Rating.neutral),
      IdentifiableRating(Rating.good),
      IdentifiableRating(Rating.veryGood),
    ];
  }
}

//TODO: make it an actual identifiable object or rename, move it to a separate file
abstract class Identifiable {
  String get id;
}

class IdentifiableRating implements Identifiable {
  final Rating rating;

  IdentifiableRating(this.rating);

  @override
  String get id => rating.toString();

  String get name {
    return rating.toName();
  }

  String get emoji {
    return rating.toEmoji();
  }
}