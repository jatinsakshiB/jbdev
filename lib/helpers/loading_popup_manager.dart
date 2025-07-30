import 'package:flutter/material.dart';

import '../jbdev.dart';
import '../ui/widget/loading_popup_widget.dart';

Route? _loadingRoute;
void showLoading(BuildContext context){
  if (_loadingRoute != null) return;
  _loadingRoute = DialogRoute(
      context: context,
      barrierDismissible: false,
      builder: (context){
        return PopScope(
          canPop: false,
          child: Builder(
              builder: JBConfig.loadingPopupBuilder ?? (context) {
                return LoadingPopupWidget();
              }
          ).centered(),
        );
      }
  );
  Navigator.of(context).push(_loadingRoute!);
}

void hideLoading() {
  if (_loadingRoute != null && _loadingRoute!.isActive) {
    Navigator.of(_loadingRoute!.navigator!.context).removeRoute(_loadingRoute!);
    _loadingRoute = null;
  }
}
