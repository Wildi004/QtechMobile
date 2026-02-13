import 'package:flutter/material.dart';

class AnimatedGridHelper {
  static List<AnimationController> makeControllers({
    required int length,
    required TickerProvider vsync,
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return List.generate(
      length,
      (_) => AnimationController(vsync: vsync, duration: duration),
    );
  }

  static List<Animation<double>> makeFadeAnimations(
    List<AnimationController> controllers,
  ) {
    return controllers
        .map((c) => Tween(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: c, curve: Curves.easeOut),
            ))
        .toList();
  }

  static List<Animation<double>> makeScaleAnimations(
    List<AnimationController> controllers, {
    double begin = 0.6,
    Curve curve = Curves.elasticOut,
  }) {
    return controllers
        .map((c) => Tween(begin: begin, end: 1.0).animate(
              CurvedAnimation(parent: c, curve: curve),
            ))
        .toList();
  }

  static Future<void> runSequentially(
    List<AnimationController> controllers, {
    required TickerProvider vsync,
    Duration delay = const Duration(milliseconds: 70),
  }) async {
    for (int i = 0; i < controllers.length; i++) {
      await Future.delayed(delay);
      // ⛔ Cegah error jika widget sudah dispose
      if (vsync is State && !(vsync as State).mounted) return;
      controllers[i].forward();
    }
  }

  static void disposeControllers(List<AnimationController> controllers) {
    for (final c in controllers) {
      c.dispose();
    }
  }
}
