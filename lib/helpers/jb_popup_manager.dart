import 'dart:ui';

import 'package:flutter/material.dart';

import '../jbdev.dart';
import '../ui/jb_bottom_sheet/jb_bottom_sheet.dart';
import '../ui/widget/jb_bottom_sheet_widget.dart';
import '../ui/widget/jb_popup_widget.dart';

void showJBPopup(BuildContext context, JBPopup popup) {
  _JBPopupManager.show(context, popup);
}

void hideJBPopup(String id){
  _JBPopupManager.hide(id);
}

void hideJBAllPopups(){
  _JBPopupManager.hideAll();
}

class _JBPopupManager {
  static final Map<String, Route> _popupRoutes = {};

  static Future<void> show(BuildContext context, JBPopup popup) async {
    if (popup.delay != null) {
      await Future.delayed(popup.delay!.milliseconds);
    }
    if (!context.mounted) return;

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
                final child = popup.builder != null
                    ? popup.builder!(context, popup)
                    : JBConfig.bottomSheetBuilder != null
                    ? JBConfig.bottomSheetBuilder!(context, popup)
                    : JBBottomSheetWidget(popup: popup);

                return JBConfig.bottomSheetBackgroundBuilder != null
                    ? JBConfig.bottomSheetBackgroundBuilder!(context, popup, () => child)
                    : child;
              },
            ),
          );
        },
        isDismissible: popup.dismissible,
        backgroundColor: JBConfig.bottomSheetBackgroundBuilder != null ? null : popup.backgroundColor ?? JBConfig.bottomSheetBackgroundColor,
        barrierBlur: JBConfig.bottomSheetBarrierBlur,
        modalBarrierColor: JBConfig.popupBarrierColor,
        shape: JBConfig.bottomSheetBackgroundBuilder != null ? null : RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(JBConfig.bottomSheetBorderRadius)),
        ),
        isScrollControlled: true,
      );
    } else {
      route = DialogRoute(
        context: context,
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
                    color: JBConfig.popupBackgroundColor ?? context.colors.surface,
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
                          if (JBConfig.popupBuilder != null){
                            return JBConfig.popupBuilder!(context, popup);
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
    Navigator.of(context).push(route);
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
