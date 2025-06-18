import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final List<Widget> actions;
  final String title;
  const CustomAppbar({super.key, this.actions = const [], required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: actions,
      title: Text(title, style: TextStyle(color: Colors.white)),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CA1AF), Color(0xFF808080)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
