extension StringExtension on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// Returns the string with the first letter capitalized.
  String get capitalize => isNullOrEmpty ? "" : '${this![0].toUpperCase()}${this!.substring(1)}';

  /// Returns the string in title case (each word starts with an uppercase letter).
  String get titleCase => isNullOrEmpty ? "" : this!.split(" ").map((word) => word.isEmpty ? "" : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}').join(" ");

  /// Converts string to camelCase (e.g., "hello world" → "helloWorld")
  String get camelCase {
    final words = this!.split(RegExp(r'\s+'));
    return isNullOrEmpty ? "" : words.first.toLowerCase() + words.skip(1).map((w) => w.capitalize).join();
  }

  /// Converts string to snake_case.
  String get snakeCase => isNullOrEmpty ? "" : this!
      .trim()
      .replaceAllMapped(RegExp(r'[A-Z]'), (match) => '_${match.group(0)!.toLowerCase()}')
      .replaceAll(RegExp(r'\s+'), '_')
      .replaceAll(RegExp(r'[^a-z0-9_]'), '')
      .toLowerCase();

  /// Converts string to URL slug (e.g., "Hello World!" → "hello-world")
  String get slugify => isNullOrEmpty ? "" : this!.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'^-+|-+$'), '');

  /// Converts slug to string (e.g., "hello-world" → "Hello World")
  String get unslugify {
    if (this == null || this!.isEmpty) return "";
    return this!
        .replaceAll('-', ' ') // replace dashes with spaces
        .split(' ')           // split into words
        .map((word) => word.capitalize) // capitalize each
        .join(' ');
  }

  /// Returns true if the string represents a numeric value.
  bool get isNumeric => !isNullOrEmpty && num.tryParse(this!) != null;


  /// Returns true if the string is a valid email address.
  bool get isEmail =>
      !isNullOrEmpty &&
          RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(this!);


  /// Returns true if the string is a valid Indian phone number (10 digits).
  bool get isPhone =>
      !isNullOrEmpty &&
          RegExp(r"^[6-9]\d{9}$").hasMatch(this!);

  /// Returns true if the string contains only alphabets.
  bool get isAlphabetOnly =>
      !isNullOrEmpty &&
          RegExp(r"^[a-zA-Z]+$").hasMatch(this!);

  /// Returns true if the string is a valid URL.
  bool get isUrl =>
      !isNullOrEmpty &&
          Uri.tryParse(this!)?.hasAbsolutePath == true;

  /// Returns true if the string is a valid Indian PAN card format.
  bool get isPan =>
      !isNullOrEmpty &&
          RegExp(r"^[A-Z]{5}[0-9]{4}[A-Z]$").hasMatch(this!);

  /// Returns true if the string is a valid Indian Aadhaar number.
  bool get isAadhaar =>
      !isNullOrEmpty &&
          RegExp(r"^\d{12}$").hasMatch(this!);

  /// Returns true if the string matches the given regular expression pattern.
  bool isMatch(String pattern) =>
      !isNullOrEmpty && RegExp(pattern).hasMatch(this!);


  /// Validates a strong password (8–16 chars, upper, lower, number, special).
  bool get isStrongPassword {
    if (isNullOrEmpty) return false;
    return RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,16}$')
        .hasMatch(this!);
  }

  /// Validates a basic password (at least 6 digits).
  bool get isBasicPassword {
    if (isNullOrEmpty) return false;
    return RegExp(r'^\d{6,}$').hasMatch(this!);
  }


  /// Returns enum class from string
  T toEnum<T extends Enum>({required List<T> values, T? fallback}) {
    return values.firstWhere(
          (e) => e.name == this,
      orElse: () => fallback ?? values.first,
    );
  }
}