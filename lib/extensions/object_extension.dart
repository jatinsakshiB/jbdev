extension ObjectExtension on Object? {
  /// Try to parse to num, fallback to [def]
  num toNum({num def = 0}) {
    if (this == null) return def;
    return num.tryParse(toString()) ?? def;
  }

  /// Try to parse to double, fallback to [def]
  double toDouble({double def = 0}) {
    if (this == null) return def;
    return double.tryParse(toString()) ?? def;
  }

  /// Try to parse to int, fallback to [def]
  int toInt({int def = 0}) {
    if (this == null) return def;
    return int.tryParse(toString()) ?? def;
  }

  /// Try to parse to bool, fallback to [def]
  bool toBool({bool def = false}) {
    if (this == null) return def;
    final value = toString().toLowerCase();
    if (value == 'true' || value == '1') return true;
    if (value == 'false' || value == '0') return false;
    return def;
  }

  String toStr({String def = ''}) {
    return this?.toString() ?? def;
  }

  /// Try to parse to DateTime, fallback to null or [fallback]
  DateTime? toDateTime({DateTime? fallback}) {
    if (this == null) return fallback;
    return DateTime.tryParse(toString()) ?? fallback;
  }

  /// Cast to Map<String, dynamic> if possible
  Map<String, dynamic>? toMap() {
    if (this is Map<String, dynamic>) return this as Map<String, dynamic>;
    return null;
  }

  /// Cast to List if possible
  List<dynamic>? toList() {
    if (this is List) return this as List<dynamic>;
    return null;
  }

  /// Returns true if value is empty (null, empty string, empty map or list)
  bool get isEmptyValue {
    if (this == null) return true;
    if (this is String && (this as String).trim().isEmpty) return true;
    if (this is Iterable && (this as Iterable).isEmpty) return true;
    if (this is Map && (this as Map).isEmpty) return true;
    return false;
  }

  /// Returns true if value is not empty
  bool get isNotEmptyValue => !isEmptyValue;
}
