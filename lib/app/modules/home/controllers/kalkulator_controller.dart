import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class KalkulatorController extends GetxController {
  RxString display = '0'.obs;
  RxString preview = ''.obs;
  bool _waitingSecondNumber = false;
  Rx<Offset> position = const Offset(100, 150).obs;
  double _angka1 = 0;
  String _operator = '';
  final formatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  void input(String value) {
    if (_waitingSecondNumber && display.value == '0') {
      display.value = value;
      _waitingSecondNumber = false;
    } else {
      display.value = display.value == '0' ? value : display.value + value;
    }
  }

  void operator(String op) {
    if (_waitingSecondNumber) {
      _operator = op;
      preview.value = '${_angka1.toInt()} $op';
      return;
    }
    _angka1 = double.parse(display.value);
    _operator = op;
    _waitingSecondNumber = true;

    preview.value = '${display.value} $op';
    display.value = '0';
  }

  void hitung() {
    final angka2 = double.parse(display.value);
    double hasil = 0;
    switch (_operator) {
      case '+':
        hasil = _angka1 + angka2;
        break;
      case '-':
        hasil = _angka1 - angka2;
        break;
      case 'x':
        hasil = _angka1 * angka2;
        break;
      case '/':
        hasil = angka2 == 0 ? 0 : _angka1 / angka2;
        break;
    }
    preview.value = '${_angka1.toInt()} $_operator ${angka2.toInt()}';
    display.value = hasil.toStringAsFixed(0);
    _waitingSecondNumber = false;
  }

  String get displayRp {
    final value = double.tryParse(display.value) ?? 0;
    return formatter.format(value);
  }

  void remove() {
    if (display.value.length > 1) {
      display.value = display.value.substring(0, display.value.length - 1);
    } else {
      display.value = '0';
    }
  }

  void clear() {
    display.value = '0';
    preview.value = '';
    _angka1 = 0;
    _operator = '';
    _waitingSecondNumber = false;
  }

  void updatePosition(DragUpdateDetails details) {
    position.value += details.delta;
  }
}
