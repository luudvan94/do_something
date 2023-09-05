import 'package:flutter/material.dart';

Rect calculateCenterArea(
  Size screenSize,
  double horizontalThresholdPercentage,
  double verticalThresholdPercentage,
) {
  final double horizontalThreshold =
      screenSize.width * horizontalThresholdPercentage;
  final double verticalThreshold =
      screenSize.height * verticalThresholdPercentage;

  final double left = (screenSize.width - horizontalThreshold) / 2;
  final double right = (screenSize.width + horizontalThreshold) / 2;
  final double top = (screenSize.height - verticalThreshold) / 2;
  final double bottom = (screenSize.height + verticalThreshold) / 2;

  return Rect.fromLTRB(left, top, right, bottom);
}
