import 'package:flutter/material.dart';

class AnimatedRemovableItem extends StatefulWidget {
  final Widget child;
  final VoidCallback onRemove;

  const AnimatedRemovableItem({
    super.key,
    required this.child,
    required this.onRemove,
  });

  @override
  State<AnimatedRemovableItem> createState() => _AnimatedRemovableItemState();
}

class _AnimatedRemovableItemState extends State<AnimatedRemovableItem>
    with SingleTickerProviderStateMixin {
  bool _visible = true;

  void _handleRemove() {
    setState(() => _visible = false);
    Future.delayed(const Duration(milliseconds: 300), widget.onRemove);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _visible ? 1 : 0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                widget.child,
                Positioned(
                  right: 0,
                  top: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.red),
                    onPressed: _handleRemove,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
