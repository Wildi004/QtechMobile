import 'package:flutter/material.dart';

class BlinkingIcon extends StatefulWidget {
  final Icon icon;
  final Duration duration;
  final double beginOpacity;
  final double endOpacity;

  const BlinkingIcon({
    super.key,
    required this.icon,
    this.duration = const Duration(milliseconds: 700),
    this.beginOpacity = 0.3,
    this.endOpacity = 1.0,
  });

  @override
  State<BlinkingIcon> createState() => _BlinkingIconState();
}

class _BlinkingIconState extends State<BlinkingIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: widget.beginOpacity,
      end: widget.endOpacity,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.icon,
    );
  }
}
