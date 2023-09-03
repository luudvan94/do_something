import 'dart:math';

int calculateAnkiInterval(int doneCount, int difficulty) {
  int maxInterval = 30; // Maximum days to wait, you can adjust this
  int baseInterval = min(
      maxInterval, (2 * pow(doneCount, 0.8) * pow(difficulty, 0.5)).toInt());

  // If the task is high difficulty and doneCount is above a certain threshold, reduce the interval
  if (difficulty >= 4 && doneCount > 5) {
    baseInterval = max(1, (baseInterval * 0.6).toInt());
  }

  // Special condition to ensure max interval
  if (difficulty == 5 && doneCount > 10) {
    return maxInterval;
  }

  // Ensure the interval does not exceed maxInterval
  return min(baseInterval, maxInterval);
}
