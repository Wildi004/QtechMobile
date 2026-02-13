import 'package:flutter/material.dart';

class SlideFadeTransition extends StatelessWidget {
  final Widget child;
  final bool slideUp;

  const SlideFadeTransition({
    super.key,
    required this.child,
    this.slideUp = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) {
        final offset = Tween<Offset>(
          begin: Offset(0, slideUp ? 0.2 : -0.2),
          end: Offset.zero,
        ).animate(animation);

        return SlideTransition(
          position: offset,
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
