import 'package:flutter/material.dart';

extension HexColorExtension on String {
  Color get hex {
    var hex = replaceAll('#', '');
    if (hex.length == 6) {
      hex = 'FF$hex';
    }
    return Color(int.parse('0x$hex'));
  }
}
