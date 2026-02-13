import 'package:flutter/material.dart';
import 'dart:math';

class CustomLoading extends StatefulWidget {
  const CustomLoading({super.key});

  @override
  State<CustomLoading> createState() => _CustomLoadingState();
}

class _CustomLoadingState extends State<CustomLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double radius = 30;
    int dotCount = 8;

    return Center(
      child: SizedBox(
        width: 100,
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Logo tengah
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/images/icon.png',
                    width: 50,
                    height: 50,
                  ),
                ),
              ),
            ),

            // Dot animasi
            AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                List<Widget> dots = [];

                double curvedValue =
                    Curves.easeInOut.transform(_controller.value);

                for (int i = 0; i < dotCount; i++) {
                  double angle = 2 * pi * i / dotCount +
                      2 * pi * curvedValue; // rotasi penuh
                  double offsetX = radius * cos(angle);
                  double offsetY = radius * sin(angle);

                  // Scale animasi bergantian
                  double scale = 0.7 +
                      0.3 *
                          sin(_controller.value * 2 * pi +
                              (i * pi / 4)); // delay by index

                  dots.add(
                    Positioned(
                      left: 50 + offsetX - 5,
                      top: 50 + offsetY - 5,
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 163, 53, 45),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Stack(children: dots);
              },
            ),
          ],
        ),
      ),
    );
  }
}
