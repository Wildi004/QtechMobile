import 'package:flutter/material.dart';

class CustomAppbarKasbon extends StatelessWidget {
  final String title;
  final VoidCallback? onBack;

  const CustomAppbarKasbon({
    super.key,
    required this.title,
    this.onBack,
  });

  static const Color backgroundColor = Color(0xFFAC7823);

  static const TextStyle titleStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  static BoxDecoration get gradientBackground => BoxDecoration(
        gradient: LinearGradient(
          colors: [backgroundColor, backgroundColor],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: gradientBackground.copyWith(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack ?? () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                title,
                style: titleStyle,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}
