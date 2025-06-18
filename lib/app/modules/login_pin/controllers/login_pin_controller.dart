import 'package:get/get.dart';

class LoginPinController extends GetxController {
  var pin = ''.obs;
  final int pinLength = 4; // Panjang PIN

  void addDigit(String digit) {
    if (pin.value.length < pinLength) {
      pin.value += digit;
    }
    if (pin.value.length == pinLength) {
      verifyPin();
    }
  }

  void deleteDigit() {
    if (pin.value.isNotEmpty) {
      pin.value = pin.value.substring(0, pin.value.length - 1);
    }
  }

  /// Mengembalikan PIN sebagai Number (int)
  int? getPinAsNumber() {
    return pin.value.isEmpty ? null : int.tryParse(pin.value);
  }

  void verifyPin() {
    // Ambil PIN dalam bentuk number
    int? enteredPin = getPinAsNumber();

    // Contoh PIN benar
    const correctPin = 1234;

    if (enteredPin == correctPin) {
      Get.snackbar("Sukses", "PIN Benar!", snackPosition: SnackPosition.BOTTOM);
      Future.delayed(Duration(milliseconds: 500), () {
        Get.offAllNamed('/home'); // Navigasi ke halaman lain jika sukses
      });
    } else {
      Get.snackbar("Gagal", "PIN Salah!", snackPosition: SnackPosition.BOTTOM);
      pin.value = ''; // Reset PIN setelah gagal
    }
  }
}
