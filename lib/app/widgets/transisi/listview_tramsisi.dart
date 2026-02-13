import 'package:flutter/material.dart';

class ListItemAnimasi extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration delay;
  final Duration duration;
  final Offset beginOffset;

  static final Set<int> animatedItems = {}; // simpan index yang sudah animasi

  const ListItemAnimasi({
    super.key,
    required this.child,
    required this.index,
    this.delay = const Duration(milliseconds: 80),
    this.duration = const Duration(milliseconds: 500),
    this.beginOffset = const Offset(-0.3, 0),
  });

  @override
  State<ListItemAnimasi> createState() => _ListItemAnimasiState();
}

class _ListItemAnimasiState extends State<ListItemAnimasi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);
    _fade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
    _slide = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // ✅ Hanya animasikan jika belum pernah
    if (!ListItemAnimasi.animatedItems.contains(widget.index)) {
      Future.delayed(widget.delay * (widget.index % 10), () {
        if (mounted) _controller.forward();
      });

      ListItemAnimasi.animatedItems.add(widget.index);
    } else {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: widget.child,
      ),
    );
  }
}

//
class StackItemAnimasi extends StatefulWidget {
  final Widget child;
  final int index;

  /// Delay antar item (misal setiap item mundur 80ms)
  final Duration interval;

  /// Durasi animasi per item
  final Duration duration;

  /// Start offset (lebih ke bawah biar efek stack)
  final Offset beginOffset;

  const StackItemAnimasi({
    super.key,
    required this.child,
    required this.index,
    this.interval = const Duration(milliseconds: 80),
    this.duration = const Duration(milliseconds: 450),
    this.beginOffset = const Offset(0, 0.2), // dari bawah
  });

  @override
  State<StackItemAnimasi> createState() => _StackItemAnimasiState();
}

class _StackItemAnimasiState extends State<StackItemAnimasi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _fade = Tween(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _slide = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _scale = Tween(begin: 0.95, end: 1.0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // Mulai animasi berurutan (staggered)
    Future.delayed(widget.interval * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _scale,
          child: widget.child,
        ),
      ),
    );
  }
}
