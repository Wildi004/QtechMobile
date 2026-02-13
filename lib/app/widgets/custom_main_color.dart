// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class CustomMainColor {
  static BoxDecoration main({
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        // colors: ['A52A2C'.hex, 'AC7823'.hex],
        colors: ['#5B2A2A'.hex, '#5B2A2A'.hex],
        // colors: ['1d987c '.hex, '0649d5'.hex],
        // colors: ['96942C '.hex, '768F13'.hex],
        // colors: ['39C6D0 '.hex, '768F13'.hex],
        // colors: ['1d987c '.hex, '013EBD'.hex],

        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow ??
          [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(4, 4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              offset: const Offset(-4, -4),
              blurRadius: 8,
            ),
          ],
    );
  }
}
