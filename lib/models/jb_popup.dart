
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:jbdev/jbdev.dart';
import 'package:jbdev/extensions/list_extension.dart';

enum JBPopupDisplay {
  dialog,
  bottomSheet,
}

enum JBPopupPosition {
  topCenter,
  topLeft,
  topRight,
  center,
  centerLeft,
  centerRight,
  bottomCenter,
  bottomLeft,
  bottomRight,
}


class JBPopup {
  final String id;
  final String? image;
  final String? title;
  final String? content;
  final bool dismissible;
  final num? delay;
  final List<JBAction> actions;
  final Color? backgroundColor;
  final JBPopupDisplay display;
  final JBPopupPosition position;
  final Widget Function(BuildContext, JBPopup)? builder;

  JBPopup({
    String? id,
    this.image,
    this.title,
    this.content,
    this.dismissible = true,
    this.delay,
    this.actions = const [],
    this.backgroundColor,
    JBPopupPosition? position,
    JBPopupDisplay? display,
    this.builder,
  }) : id = id ?? UniqueKey().toString(),
        position = position ?? JBPopupPosition.center,
        display = display ?? JBPopupDisplay.dialog;

  void show({BuildContext? context}){
    showJBPopup(this, context: context);
  }

  factory JBPopup.fromJson(Map<String, dynamic> json) => JBPopup(
    id: json['id'] ?? UniqueKey().toString(),
    image: json['image'],
    title: json['title'],
    content: json['message'],
    dismissible: json['dismissible'] ?? true,
    delay: json['delay'],
    actions: (json['actions'] as List<dynamic>?)
        ?.map((e) => JBAction.fromJson(e)).toList() ?? [],
    backgroundColor: json['backgroundColor'] != null
        ? HexColor.fromHex(json['backgroundColor'])
        : null,
    position: JBPopupPosition.values.fromString(json['position'], fallback: JBPopupPosition.center),
    display: JBPopupDisplay.values.fromString(json['display'], fallback: JBPopupDisplay.dialog),
  );

  Map<String, dynamic> toJson() => {
    'image': image,
    'title': title,
    'message': content,
    'dismissible': dismissible,
    'delay': delay,
    'actions': actions.map((e) => e.toJson()).toList(),
    'backgroundColor': backgroundColor?.toHex(),
    'position': position.name,
    'display': display.name,
  };


}



extension JBPopupPositionAlignment on JBPopupPosition {
  Alignment get alignment {
    switch (this) {
      case JBPopupPosition.topLeft:
        return Alignment.topLeft;
      case JBPopupPosition.topCenter:
        return Alignment.topCenter;
      case JBPopupPosition.topRight:
        return Alignment.topRight;
      case JBPopupPosition.centerLeft:
        return Alignment.centerLeft;
      case JBPopupPosition.center:
        return Alignment.center;
      case JBPopupPosition.centerRight:
        return Alignment.centerRight;
      case JBPopupPosition.bottomLeft:
        return Alignment.bottomLeft;
      case JBPopupPosition.bottomCenter:
        return Alignment.bottomCenter;
      case JBPopupPosition.bottomRight:
        return Alignment.bottomRight;
    }
  }
}
