
import 'package:intl/intl.dart';
import 'package:jbdev/enums/jb_timezone.dart';

import '../app.dart';
import '../utils/jb_config.dart';


extension DateTimeExtensions on DateTime {

  /// Converts to the timezone offset defined in [JBConfig.setTimezone]
  DateTime toJBTimezone() => toUtc().add(App.timezone.offset);


  /// Format using a custom pattern (default 'yyyy-MM-dd')
  String toFormattedDate({String pattern = 'yyyy-MM-dd'}) {
    return DateFormat(pattern, App.localeCode).format(toJBTimezone());
  }

  /// Format: 'MMM dd, yyyy' → Example: 'Feb 15, 2025'
  String toShortDate() {
    return DateFormat('MMM dd, yyyy', App.localeCode).format(toJBTimezone());
  }

  /// Format: 'hh:mm a' → Example: '10:30 AM'
  String toTime() {
    return DateFormat('hh:mm a', App.localeCode).format(toJBTimezone());
  }

  /// Format: 'dd MMM ''yy, hh:mma' → Example: '15 Feb '25, 10:30AM'
  String toFullDateTime() {
    return DateFormat("dd MMM ''yy, hh:mma", App.localeCode).format(toJBTimezone());
  }

  /// Relative string like 'Today', 'Yesterday', '2 days ago'
  String toRelativeTime() {
    final now = DateTime.now().toUtc().add(App.timezone.offset);
    final local = toJBTimezone();
    final diff = now.difference(local);

    if (diff.inDays == 0) return "Today";
    if (diff.inDays == 1) return "Yesterday";
    if (diff.inDays < 7) return "${diff.inDays} days ago";
    return toShortDate();
  }

  /// Returns the age in years based on this date.
  int get age {
    final today = DateTime.now().toUtc().add(App.timezone.offset);
    int years = today.year - year;
    if (today.month < month || (today.month == month && today.day < day)) {
      years--;
    }
    return years;
  }

  /// Returns true if this date is today.
  bool get isToday {
    final now = DateTime.now().toUtc().add(App.timezone.offset);
    return year == now.year && month == now.month && day == now.day;
  }

  /// Returns true if this date is the same day as [other].
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Returns true if this date is Saturday or Sunday.
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;


  /// Number of days until another date.
  int daysUntil(DateTime other) => other.difference(this).inDays;
}