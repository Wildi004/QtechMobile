import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class BellIcon extends StatefulWidget {
  const BellIcon({super.key});

  @override
  State<BellIcon> createState() => _BellIconState();
}

class _BellIconState extends State<BellIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _animation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 0.4), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: -0.4), weight: 2),
      TweenSequenceItem(tween: Tween(begin: -0.4, end: 0.4), weight: 2),
      TweenSequenceItem(tween: Tween(begin: 0.4, end: 0), weight: 1),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  void _shakeBell() {
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _shakeBell();
        // Aksi lain kalau mau
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: child,
          );
        },
        child: LzImage(
          'icon notifikasi.png',
          size: 30,
        ),
      ),
    );
  }
}
