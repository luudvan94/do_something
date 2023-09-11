import 'package:intl/intl.dart';

bool isSameDate(DateTime dateA, DateTime dateB) {
  return dateA.year == dateB.year &&
      dateA.month == dateB.month &&
      dateA.day == dateB.day;
}

extension DateTimeExtension on DateTime {
  String formattedDate(
          {String dayFormat = 'MMM dd, yyyy', String? timeFormat}) =>
      DateFormat('$dayFormat ${timeFormat != null ? ', $timeFormat' : ''}')
          .format(toLocal())
          .toLowerCase();
}
