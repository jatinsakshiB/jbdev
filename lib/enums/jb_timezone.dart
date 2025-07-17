enum JBTimezone {
  utc,
  ist, // Asia/Kolkata
}

extension JBTimezoneOffset on JBTimezone {
  Duration get offset {
    switch (this) {
      case JBTimezone.ist:
        return const Duration(hours: 5, minutes: 30);
      default:
        return Duration.zero;
    }
  }
}
