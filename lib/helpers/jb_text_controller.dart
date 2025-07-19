import 'package:flutter/cupertino.dart';

class JBTextController extends TextEditingController {
  String? error;

  JBTextController({super.text});

  bool validate(String pattern, {String? emptyMsg, String? invalidMsg}) {
    if (text.trim().isEmpty) {
      error = emptyMsg ?? 'This field is required';
    } else if (!RegExp(pattern).hasMatch(text.trim())) {
      error = invalidMsg ?? 'Please enter a valid value';
    } else {
      error = null;
    }
    notifyListeners();
    return error == null;
  }

  void clearError() {
    error = null;
    notifyListeners();
  }
  void showError(String error) {
    this.error = error;
    notifyListeners();
  }
}

class JBValidators {
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const phone = r'^[6-9]\d{9}$';
  static const password = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const name = r'^[a-zA-Z ]{2,}$';
  static const otp4 = r'^\d{4}$';
  static const otp6 = r'^\d{6}$';
}
