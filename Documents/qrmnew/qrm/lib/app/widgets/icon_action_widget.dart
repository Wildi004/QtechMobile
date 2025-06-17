import 'package:flutter/material.dart';

class IconAction extends StatelessWidget {
  final IconData icon;
  final Function()? onTap;
  const IconAction(this.icon, {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
    );
  }
}
