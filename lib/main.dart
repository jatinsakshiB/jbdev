/*
import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';

import 'models/jb_popup.dart';

void main() {
  runApp(MaterialApp(
    navigatorKey: jbNavigatorKey,
    home: Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Center(
            child: JBButton(onPressed: (){
              showJBPopup(JBPopup(
                title: 'Preview Title',
                content: 'This is a visual preview of JBPopup. <h1>This is a visual preview of JBPopup.</h1>',
                display: JBPopupDisplay.bottomSheet,
                position: JBPopupPosition.center,
                actions: [
                  JBAction(label: 'Okay', onAction: () => print('Okay tapped'), metadata: {"button_type": "success"}),
                  JBAction(label: 'Close', onAction: () => print('Okay tapped'), metadata: {"button_type": "error"}),
                ],
              ));

            }, text: "test", icon: Icon(Icons.remember_me), type: "success",),
          ),
        );
      }
    ),
  ));
}
*/
