import 'package:do_something/src/utils/anki.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
      'calculateAnkiInterval returns correct interval for doneCount=1, for each difficulty',
      () {
    expect(calculateAnkiInterval(1, 1), 2);
    expect(calculateAnkiInterval(1, 2), 2);
    expect(calculateAnkiInterval(1, 3), 3);
    expect(calculateAnkiInterval(1, 4), 4);
    expect(calculateAnkiInterval(1, 5), 4);
  });

  test(
      'calculateAnkiInterval returns correct interval for doneCount=2, difficulty=1',
      () {
    expect(calculateAnkiInterval(2, 1), 3);
  });

  test(
      'calculateAnkiInterval returns correct interval for doneCount=1, difficulty=2',
      () {
    expect(calculateAnkiInterval(1, 2), 2);
  });

  test(
      'calculateAnkiInterval returns correct interval for doneCount=2, difficulty=2',
      () {
    expect(calculateAnkiInterval(2, 2), 4);
  });

  test(
      'calculateAnkiInterval returns correct interval for doneCount=3, difficulty=5',
      () {
    expect(calculateAnkiInterval(3, 5), 10);
  });

  test(
      'calculateAnkiInterval returns reduced interval for high difficulty and high doneCount',
      () {
    expect(calculateAnkiInterval(6, 4), 9); // Reduced by 20%
  });

  test('calculateAnkiInterval does not exceed max interval', () {
    expect(calculateAnkiInterval(100, 5), 30); // Capped at maxInterval
  });
}
