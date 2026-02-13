import 'package:flutter/material.dart';

class CustomScalaContainer extends StatefulWidget {
  final Widget child;
  final double scaleDownFactor;

  final EdgeInsetsGeometry? padding;
  final Decoration? decoration;

  final VoidCallback? onTap;

  const CustomScalaContainer({
    super.key,
    required this.child,
    this.scaleDownFactor = 0.9,
    this.padding,
    this.decoration,
    this.onTap, // ✅
  });

  @override
  State<CustomScalaContainer> createState() => _CustomScalaContainerState();
}

class _CustomScalaContainerState extends State<CustomScalaContainer> {
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
    return MouseRegion(
      onEnter: (_) => _scaleDown(),
      onExit: (_) => _scaleUp(),
      child: GestureDetector(
        onTap: widget.onTap, // ✅ Panggil callback tap di sini
        onTapDown: (_) => _scaleDown(),
        onTapUp: (_) => _scaleUp(),
        onTapCancel: _scaleUp,
        child: AnimatedScale(
          scale: _currentScale,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
          child: Container(
            padding: widget.padding,
            decoration: widget.decoration,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
