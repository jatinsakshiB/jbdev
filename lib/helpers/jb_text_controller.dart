import 'package:flutter/cupertino.dart';
import 'package:jbdev/jbdev.dart';

class JBTextController extends TextEditingController {
  final ValueNotifier<JBTextFieldState> stateNotifier = ValueNotifier(const JBTextFieldState());
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  JBTextController({super.text});

  bool validate(String pattern, {String? emptyMsg, String? invalidMsg, String? fieldName}) {
    if (text.trim().isEmpty) {
      showError(
          emptyMsg
              ?? JBConfig.defaultTextFieldErrors.requiredErrorText?.call(fieldName ?? "")
              ?? 'This field is required'
      );
    } else if (!RegExp(pattern).hasMatch(text.trim())) {
      showError(invalidMsg ?? JBConfig.defaultTextFieldErrors.invalidErrorText?.call(fieldName ?? "") ?? 'Please enter a valid value');
    } else {
      clearError();
    }
    notifyListeners();
    return errorNotifier.value == null;
  }

  void showError(String error) {
    errorNotifier.value = error;
  }

  void clearError() {
    errorNotifier.value = null;
  }

  void obscureText(bool obscure) {
    stateNotifier.value = stateNotifier.value.copyWith(obscureText: obscure);
  }

  void enabled(bool enabled) {
    stateNotifier.value = stateNotifier.value.copyWith(enabled: enabled);
  }

  bool get isObscured => stateNotifier.value.obscureText;
  bool get isEnabled => stateNotifier.value.enabled;
}

class JBTextFieldState {
  final bool enabled;
  final bool obscureText;

  const JBTextFieldState({this.enabled = true, this.obscureText = false});

  JBTextFieldState copyWith({bool? enabled, bool? obscureText}) {
    return JBTextFieldState(
      enabled: enabled ?? this.enabled,
      obscureText: obscureText ?? this.obscureText,
    );
  }
}

class JBValidators {
  // Email validation: Standard email format
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  // Indian phone number: Must start with 6-9 and be exactly 10 digits
  static const phone = r'^[6-9]\d{9}$';

  // Password: Minimum 6 characters, at least one letter and one number
  static const password = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';

  // Name: Only alphabets and space, minimum 2 characters
  static const name = r'^[a-zA-Z ]{2,}$';

  // OTP (4-digit)
  static const otp4 = r'^\d{4}$';

  // OTP (6-digit)
  static const otp6 = r'^\d{6}$';

  // Not empty: Matches any string that has at least one non-whitespace character
  static const notEmpty = r'^.*\S.*$';

  // Alphanumeric (with spaces allowed)
  static const alphanumericWithSpaces = r'^[a-zA-Z0-9 ]+$';

  // Alphabets only (with spaces allowed)
  static const alphabetsOnly = r'^[a-zA-Z ]+$';

  // Numeric only
  static const numericOnly = r'^\d+$';

  // Decimal numbers (with optional 2 digits after the decimal point)
  static const decimal = r'^\d+(\.\d{1,2})?$';

  // URL validation (basic pattern)
  static const url = r'^(https?:\/\/)?([\w\-])+\.{1}([a-zA-Z]{2,63})([\/\w \.-]*)*\/?$';

  // Date (yyyy-mm-dd format)
  static const date = r'^\d{4}-\d{2}-\d{2}$';

  // Time (HH:mm or HH:mm:ss format)
  static const time = r'^([01]\d|2[0-3]):([0-5]\d)(:[0-5]\d)?$';

  // Pincode (India): 6 digits only
  static const pincode = r'^\d{6}$';

  // Aadhaar number (India): 12 digits, grouped in 4s
  static const aadhaar = r'^\d{4}\s\d{4}\s\d{4}$';

  // PAN card (India): 5 letters, 4 digits, 1 letter
  static const pan = r'^[A-Z]{5}[0-9]{4}[A-Z]{1}$';

  // IFSC code (India): 4 letters, 0, and 6 digits
  static const ifsc = r'^[A-Z]{4}0[A-Z0-9]{6}$';

  // GSTIN (India): 15 character alphanumeric
  static const gstin = r'^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$';

  // UPI ID: name@bank format
  static const upi = r'^[\w.\-]{2,256}@[a-zA-Z]{2,64}$';
}

