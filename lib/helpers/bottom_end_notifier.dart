import 'package:flutter/material.dart';

class BottomEndNotifier extends StatelessWidget {
  final Widget child;
  final VoidCallback onEndReached;
  final double triggerOffset;

  const BottomEndNotifier({
    super.key,
    required this.child,
    required this.onEndReached,
    this.triggerOffset = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scrollNotification) {
        if (scrollNotification.metrics.pixels >=
            scrollNotification.metrics.maxScrollExtent - triggerOffset) {
          onEndReached();
        }
        return false;
      },
      child: child,
    );
  }
}
