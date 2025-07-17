import 'dart:ui';

import 'package:flutter/material.dart';

import '../jbdev.dart';
import '../ui/jb_bottom_sheet/jb_bottom_sheet.dart';
import '../ui/widget/jb_bottom_sheet_widget.dart';
import '../ui/widget/jb_popup_widget.dart';

void showJBPopup(JBPopup popup, {BuildContext? context}) {
  _JBPopupManager.show(popup, context: context);
}

void hideJBPopup(String id){
  _JBPopupManager.hide(id);
}

void hideJBAllPopups(){
  _JBPopupManager.hideAll();
}

class _JBPopupManager {
  static final Map<String, Route> _popupRoutes = {};

  static Future<void> show(JBPopup popup, {BuildContext? context}) async {
    final ctx = context ?? jbContext;
    if (ctx == null || !ctx.mounted) return;

    if (popup.delay != null) {
      await Future.delayed(popup.delay!.milliseconds);
    }

    Route route;
    if (popup.display == JBPopupDisplay.bottomSheet) {
      route = JBModalBottomSheetRoute(
        builder: (context) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: context.screenHeight * JBConfig.bottomSheetMaxHeight,
            ),
            child: Builder(
              builder: (context){
                if (popup.builder != null){
                  return popup.builder!(context, popup);
                }
                if (JBConfig.bottomSheetWidget != null){
                  return JBConfig.bottomSheetWidget!(context, popup);
                }
                return JBBottomSheetWidget(popup: popup);
              },
            ),
          );
        },
        isDismissible: popup.dismissible,
        backgroundColor: popup.backgroundColor ?? JBConfig.bottomSheetBackgroundColor,
        barrierBlur: JBConfig.bottomSheetBarrierBlur,
        modalBarrierColor: JBConfig.popupBarrierColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(JBConfig.bottomSheetBorderRadius)),
        ),
        isScrollControlled: true,
      );
    } else {
      route = DialogRoute(
        context: ctx,
        barrierDismissible: popup.dismissible,
        barrierColor: JBConfig.popupBarrierColor,
        builder: (context) {
          return Stack(
            children: [
              if (JBConfig.popupBarrierBlur != null && JBConfig.popupBarrierBlur! > 0) BackdropFilter(
                filter: ImageFilter.blur(sigmaX: JBConfig.popupBarrierBlur!, sigmaY: JBConfig.popupBarrierBlur!),
                child: Container(
                  color: JBConfig.popupBarrierColor, // faded overlay
                ),
              ).onTap((){
                hide(popup.id);
              }),

              Align(
                alignment: popup.position.alignment,
                child: Container(
                  decoration: BoxDecoration(
                    color: JBConfig.popupBackgroundColor ?? colors?.surface,
                    borderRadius: BorderRadius.all(Radius.circular(JBConfig.popupBorderRadius))
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: context.screenHeight*.8
                    ),
                    child: SingleChildScrollView(
                      child: Builder(
                        builder: (context){
                          if (popup.builder != null){
                            return popup.builder!(context, popup);
                          }
                          if (JBConfig.popupWidget != null){
                            return JBConfig.popupWidget!(context, popup);
                          }
                          return JBPopupWidget(popup: popup);
                        },
                      ),
                    ),
                  ),
                ).withPadding(JBConfig.popupPadding),
              ),
            ],
          );
        },
      );
    }

    _popupRoutes[popup.id] = route;
    Navigator.of(ctx).push(route);
  }

  static void hide(String id) {
    final route = _popupRoutes[id];
    if (route != null && route.isActive) {
      route.navigator?.removeRoute(route);
      _popupRoutes.remove(id);
    }
  }

  static void hideAll() {
    _popupRoutes.forEach((_, route) {
      if (route.isActive) {
        route.navigator?.removeRoute(route);
      }
    });
    _popupRoutes.clear();
  }
}
