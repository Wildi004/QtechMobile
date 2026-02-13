// custom_scale_view.dart
import 'package:flutter/material.dart';

class CustomScaleView extends StatefulWidget {
  final Widget child;
  final double scaleDownFactor;

  const CustomScaleView({
    super.key,
    required this.child,
    this.scaleDownFactor = 0.7,
  });

  @override
  State<CustomScaleView> createState() => _CustomScaleViewState();
}

class _CustomScaleViewState extends State<CustomScaleView> {
  double _currentScale = 1.0;

  void _scaleDown() {
    setState(() {
      _currentScale = widget.scaleDownFactor;
    });
  }

  void _scaleUp() {
    setState(() {
      _currentScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _scaleDown(),
      onTapUp: (_) => _scaleUp(),
      onTapCancel: _scaleUp,
      child: AnimatedScale(
        scale: _currentScale,
        duration: const Duration(milliseconds: 20),
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
