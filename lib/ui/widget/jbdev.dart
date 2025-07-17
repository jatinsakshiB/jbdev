
import 'package:flutter/material.dart';

import '../../app.dart';

class Jbdev extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  const Jbdev({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appNotifier,
      builder: (context, _, __) {
        return builder(context);
      },
    );
  }
}