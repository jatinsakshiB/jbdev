import 'package:flutter/material.dart';
import 'package:jbdev/helpers/jb_text_controller.dart';
import 'package:jbdev/jbdev.dart';

import 'models/jb_popup.dart';

void main() {

  var controller = JBTextController();
  runApp(MaterialApp(
    home: Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            children: [

              JBTextField(controller: controller,),

              JBButton(onPressed: (){
                controller..validate(JBValidators.email);


              }, text: "test", icon: Icon(Icons.remember_me), type: "success",),
            ],
          ),
        );
      }
    ),
  ));
}
