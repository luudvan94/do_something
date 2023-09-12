// colors extention based on rating

abstract class StringRepresentable {
  String toStringRepresentation();
}

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
        return 'rarely';
      case Rating.bad:
        return 'occasionally';
      case Rating.neutral:
        return 'neutral';
      case Rating.good:
        return 'often';
      case Rating.veryGood:
        return 'very eager';
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
      case 'rarely':
        return Rating.veryBad;
      case 'occasionally':
        return Rating.bad;
      case 'neutral':
        return Rating.neutral;
      case 'often':
        return Rating.good;
      case 'very eager':
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
  String get id => rating.toName();

  String get name {
    return rating.toName();
  }

  String get emoji {
    return rating.toEmoji();
  }
}
