import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';
import 'package:url_launcher/url_launcher_string.dart';

extension ContextExtension on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;


  TextTheme get textThemes => Theme.of(this).textTheme;

  ColorScheme get colors => Theme.of(this).colorScheme;



  void pop<T extends Object?>([T? result]) {
    Navigator.of(this).pop(result);
  }


  void launchActions(List<JBAction>? actions) {
    actions?.forEach((action) {
      launchAction(action);
    });
  }


  Future<bool> launchAction(JBAction? action) async{
    if (action != null) {
      if (action.url != null){
        if (action.url!.startsWith("http") ||
            action.url!.startsWith("tel:") ||
            action.url!.startsWith("mailto:")) {
          launchUrlString(action.url!, mode: LaunchMode.externalApplication);
        } else if (action.url == "pop") {
          pop();
          return false;
        }else{
          launchUrlString(action.url!);
        }
      }else if (action.popup != null){
        action.popup?.show(this);
      }
      if (action.onAction != null){
        return await action.onAction!.call();
      }
    }
    return true;
  }
}