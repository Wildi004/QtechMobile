import 'package:flutter/material.dart';

/// Helper untuk membuat BoxDecoration dengan efek bayangan 3D.
class CustomDeco3d {
  static BoxDecoration box({
    Color color = Colors.white,
    double borderRadius = 12,
    Color shadowColor1 = Colors.black12,
    Color shadowColor2 = Colors.white,
    double blurRadius = 15,
    double spreadRadius = 1,
    Offset offset1 = const Offset(4, 4),
    Offset offset2 = const Offset(-4, -4),
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: shadowColor1,
          offset: offset1,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
        BoxShadow(
          color: shadowColor2,
          offset: offset2,
          blurRadius: blurRadius,
          spreadRadius: spreadRadius,
        ),
      ],
    );
  }
}
