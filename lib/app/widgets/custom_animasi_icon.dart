import 'package:flutter/material.dart';

class CustomAnimasiIcon extends StatefulWidget {
  final IconData icon;
  final Color color;

  const CustomAnimasiIcon({
    super.key,
    required this.icon,
    required this.color,
  });

  @override
  State<CustomAnimasiIcon> createState() => _CustomAnimasiIconState();
}

class _CustomAnimasiIconState extends State<CustomAnimasiIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _opacity = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Icon(widget.icon, color: widget.color),
    );
  }
}
