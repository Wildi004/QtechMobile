import 'package:flutter/material.dart';

class RabListHelper {
  final AnimatedListState? listKeyState;

  RabListHelper({required this.listKeyState});

  void insertItem(int index) {
    listKeyState?.insertItem(index,
        duration: const Duration(milliseconds: 300));
  }

  void removeItem(
      int index, Widget Function(BuildContext, Animation<double>) builder) {
    listKeyState?.removeItem(
      index,
      builder,
      duration: const Duration(milliseconds: 300),
    );
  }
}
