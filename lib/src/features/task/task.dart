// create Task model with id, name
import 'package:do_something/src/features/task/rating.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  bool isOneTimeDone = false;

  @HiveField(3)
  String rating;

  @HiveField(4)
  DateTime reviewDate = DateTime.now();

  @HiveField(5)
  int ignoreCountLeft = 3;

  @HiveField(6)
  int doneCount = 0;

  Rating get ratingEnum => RatingExtension.fromName(rating);

  // constructor
  Task({
    this.id = '',
    required this.name,
    this.rating = '',
    required this.reviewDate,
    required this.doneCount,
  }) {
    id = id.isEmpty ? DateTime.now().toString() : id;
    rating = rating.isEmpty ? Rating.neutral.toName() : rating;
  }

  @override
  String toString() {
    // print task object
    return 'Task{id: $id, name: $name, isOneTimeDone: $isOneTimeDone, rating: $rating, reviewDate: $reviewDate, ignoreCountLeft: $ignoreCountLeft, doneCount: $doneCount}';
  }
}

extension TaskExtension on Task {
  static Task fromName(String name, Rating rating) {
    return Task(
        name: name,
        reviewDate: DateTime.now(),
        rating: rating.toName(),
        doneCount: 0);
  }
}
