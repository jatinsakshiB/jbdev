import 'package:flutter/cupertino.dart';

class JBTextController extends TextEditingController {
  final ValueNotifier<JBTextFieldState> stateNotifier = ValueNotifier(const JBTextFieldState());
  final ValueNotifier<String?> errorNotifier = ValueNotifier(null);

  JBTextController({super.text});

  bool validate(String pattern, {String? emptyMsg, String? invalidMsg}) {
    if (text.trim().isEmpty) {
      showError(emptyMsg ?? 'This field is required');
    } else if (!RegExp(pattern).hasMatch(text.trim())) {
      showError(invalidMsg ?? 'Please enter a valid value');
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
  static const email = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const phone = r'^[6-9]\d{9}$';
  static const password = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  static const name = r'^[a-zA-Z ]{2,}$';
  static const otp4 = r'^\d{4}$';
  static const otp6 = r'^\d{6}$';
}
