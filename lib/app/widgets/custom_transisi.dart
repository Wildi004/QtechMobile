import 'package:flutter/material.dart';

class AnimatedListItem extends StatelessWidget {
  final Widget child;
  final Key keyItem;
  final Duration duration;

  const AnimatedListItem({
    super.key,
    required this.child,
    required this.keyItem,
    this.duration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: AnimatedSize(
        duration: duration,
        curve: Curves.easeInOut,
        child: Container(
          key: keyItem,
          child: child,
        ),
      ),
    );
  }
}
