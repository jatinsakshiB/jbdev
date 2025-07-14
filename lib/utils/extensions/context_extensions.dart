import 'package:flutter/cupertino.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  void push(String name, {Object? arguments, bool replace = false}) {
    if (replace) {
      Navigator.of(this).pushReplacementNamed(name, arguments: arguments);
      return;
    }
    Navigator.of(this).pushNamed(name, arguments: arguments);
  }

  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }
}