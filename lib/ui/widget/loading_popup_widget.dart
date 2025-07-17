import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jbdev/jbdev.dart';

class LoadingPopupWidget extends StatelessWidget {
  const LoadingPopupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(16))
      ),
      height: 80,
      width: 80,
      child: CupertinoActivityIndicator(
        color: colors?.primary,
      ),
    );
  }

}
