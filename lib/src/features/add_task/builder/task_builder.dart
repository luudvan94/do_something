import 'package:do_something/src/features/models/rating.dart';
import 'package:do_something/src/features/models/task.dart';

class TaskBuilder {
  Task? task;
  String? name;
  String details = '';
  Rating? rating;
  bool? isOneTimeDone;

  TaskBuilder({this.task}) {
    if (task != null) {
      name = task!.name;
      details = task!.details;
      rating = task!.ratingEnum;
      isOneTimeDone = task!.isOneTimeDone;
    }
  }

  void addName(String name) {
    this.name = name;
  }

  void addDetails(String details) {
    this.details = details;
  }

  void addRating(Rating rating) {
    this.rating = rating;
  }

  void addIsOneTimeDone(bool isOneTimeDone) {
    this.isOneTimeDone = isOneTimeDone;
  }

  Task build() {
    if (this.task != null) {
      this.task!.name = name ?? '';
      this.task!.details = details;
      this.task!.rating = rating?.toName() ?? '';
      this.task!.isOneTimeDone = isOneTimeDone ?? false;
      return this.task!;
    }

    var task = Task(
        name: name ?? '',
        rating: rating?.toName() ?? '',
        isOneTimeDone: isOneTimeDone ?? false,
        reviewDate: DateTime.now(),
        doneCount: 0,
        details: details);

    return task;
  }
}
