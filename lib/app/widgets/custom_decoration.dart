// ignore_for_file: deprecated_member_use
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class CustomDecoration {
  static BoxDecoration validator({
    double radius = 15,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: const Border(
        left: BorderSide(
          color: Color(0xFF7A1F2B),
          width: 10,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 6,
          spreadRadius: -2,
          offset: const Offset(0, 2),
        ),
        // Shadow utama ke bawah
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 18,
          spreadRadius: -8,
          offset: const Offset(0, 10),
        ),
        // Shadow jauh & lembut
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 36,
          spreadRadius: -16,
          offset: const Offset(0, 20),
        ),
      ],
    );
  }

  static BoxDecoration validator1({
    double radius = 15,
    BorderRadius? borderRadius,
  }) {
    return BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: const Border(
        left: BorderSide(
          color: Color(0xFF7A1F2B),
          width: 10,
        ),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.18),
          blurRadius: 6,
          spreadRadius: -2,
          offset: const Offset(0, 2),
        ),
        // Shadow utama ke bawah
        BoxShadow(
          color: Colors.black.withOpacity(0.12),
          blurRadius: 18,
          spreadRadius: -8,
          offset: const Offset(0, 10),
        ),
        // Shadow jauh & lembut
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 36,
          spreadRadius: -16,
          offset: const Offset(0, 20),
        ),
      ],
    );
  }

  static BoxDecoration defaul({
    double radius = 15,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: ['FFFFFF'.hex, 'FFFFFF'.hex],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: border,
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

  static BoxDecoration main2({
    double radius = 15,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: ['#252525'.hex, '#A92727'.hex],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: border,
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

  static BoxDecoration notValidator({
    double radius = 15,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: ['878787'.hex, '878787'.hex],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: border,
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

  static BoxDecoration orange({
    double radius = 15,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: [
          const Color.fromARGB(255, 190, 153, 97),
          const Color.fromARGB(255, 159, 121, 75),
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
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

  static BoxDecoration white({
    double radius = 15,
    BorderRadius? borderRadius,
    Border? border,
    List<BoxShadow>? boxShadow,
  }) {
    return BoxDecoration(
      gradient: LinearGradient(
        colors: ['FFFFFF'.hex, 'FFFFFF'.hex],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      ),
      borderRadius: borderRadius ?? BorderRadius.circular(radius),
      border: border,
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

Widget iosBlurActionGroup({
  required VoidCallback onEdit,
  required VoidCallback onDelete,
}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(30),
    child: Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: const SizedBox(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.18),
            border: Border.all(
              color: Colors.white.withOpacity(0.45),
              width: 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.18),
                blurRadius: 22,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(6),
                icon: const Icon(Hi.edit01, size: 18),
                color: Colors.black,
                onPressed: onEdit,
              ),
              Container(
                width: 1,
                height: 18,
                color: Colors.white.withOpacity(0.45),
              ),
              IconButton(
                constraints: const BoxConstraints(),
                padding: const EdgeInsets.all(6),
                icon: const Icon(Hi.delete02, size: 18),
                color: Colors.red,
                onPressed: onDelete,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class CustomTextStyle {
  static TextStyle title({
    double size = 15,
    FontWeight weight = FontWeight.bold,
  }) {
    return GoogleFonts.roboto(
      fontSize: size,
      fontWeight: weight,
    );
  }

  static TextStyle subtitle({
    double size = 13,
    FontWeight weight = FontWeight.normal,
    Color? color,
  }) {
    return GoogleFonts.roboto(
      fontSize: size,
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle caption({
    Color color = Colors.grey,
    double size = 11,
    FontWeight weight = FontWeight.normal,
  }) {
    return GoogleFonts.roboto(
      color: color,
      fontSize: size,
      fontWeight: weight,
    );
  }
}
