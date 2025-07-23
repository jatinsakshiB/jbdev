import 'package:flutter/material.dart';
import 'package:jbdev/helpers/jb_text_controller.dart';
import 'package:jbdev/jbdev.dart';

void main() {

  JBConfig.defaultTextField = JBTextFieldProperties(
    borderColor: Colors.black.withValues(alpha: .1),
    hintTextColor: Colors.grey,
    borderRadiusAll: 10,
    borderWidth: 2,
  );

  var controller = JBTextController();
  runApp(MaterialApp(
    home: Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              JBTextField(controller: controller, maxLines: 1, suffixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.visibility_off, size: 12, color: Colors.green,)),).withSymmetricPadding(horizontal: 26),

              26.heightBox,
              JBButton(onPressed: () async{
                controller.validate(JBValidators.email);
                await Future.delayed(2.seconds);
                controller.enabled(false);
              }, text: "test", type: "success",),
            ],
          ),
        );
      }
    ),
  ));
}
