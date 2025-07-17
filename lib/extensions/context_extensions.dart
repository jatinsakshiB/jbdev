import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;


  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }


  void launchActions(List<JBAction>? actions) {
    actions?.forEach((action) {
      launchAction(action);
    });
  }


  void launchAction(JBAction? action) {
    if (action != null) {
      if (action.url != null){
        if (action.url!.startsWith("http") ||
            action.url!.startsWith("tel:") ||
            action.url!.startsWith("mailto:")) {
          launchUrlString(action.url!, mode: LaunchMode.externalApplication);
        } else if (action.url == "pop") {
          pop();
        }else{
          launchUrlString(action.url!);
        }
      }else if (action.popup != null){
        showJBPopup(action.popup!, context: this);
      }
      action.onAction?.call();
    }
  }
}