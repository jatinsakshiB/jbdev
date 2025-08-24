import 'package:flutter/material.dart';

import '../../helpers/shared_preferences_manager.dart';

class SharedPreferencesBuilder<T> extends StatelessWidget {
  final String keyName;
  final Widget Function(BuildContext, T? value) builder;

  const SharedPreferencesBuilder({
    required this.keyName,
    required this.builder,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final notifier = SharedPreferencesManager.listen<T>(keyName);
    return ValueListenableBuilder<T?>(
      valueListenable: notifier,
      builder: (context, value, _) => builder(context, value),
    );
  }
}