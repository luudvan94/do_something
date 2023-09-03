import 'package:do_something/src/features/task/rating.dart';
import 'package:do_something/src/features/task/task.dart';

class TaskBuilder {
  String? name;
  String details = '';
  Rating? rating;
  bool? isOneTimeDone;

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
    var task = Task(
        name: name ?? '',
        rating: rating?.toName() ?? '',
        isOneTimeDone: isOneTimeDone ?? false,
        reviewDate: DateTime.now(),
        doneCount: 0);

    return task;
  }
}
