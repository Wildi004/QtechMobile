import 'package:fetchly/fetchly.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:lazyui/lazyui.dart';

extension CustomExtension on BuildContext {
  void confirm(
      {String? title,
      String? message,
      String? cancelText,
      String? confirmText,
      Function()? onConfirm}) {
    LzConfirm.show(this,
        title: title,
        message: message,
        cancelText: cancelText ?? 'Tidak',
        confirmText: confirmText ?? 'Ya',
        onConfirm: onConfirm);
  }

  void openBottomSheet(Widget page) {
    Get.bottomSheet(page,
        isScrollControlled: true, enableDrag: false, ignoreSafeArea: false);
  }
}

// Aku bikin extension `CustomFutureExtension` buat `Future<T>` supaya bisa
// nambahin fungsi tambahan langsung ke future di Flutter.
extension CustomFutureExtension<T> on Future<T> {
  // Getter `ui` ini fungsinya buat membungkus future di dalam kelas `Ui<T>`,
  // supaya bisa dipanggil dengan lebih nyaman dalam kode.
  Ui<T> get ui {
    return Ui<T>(this);
  }
}

// Ini adalah kelas `Ui<T>` yang bertanggung jawab buat menangani loading UI
// saat future sedang diproses.
class Ui<T> {
  final Future<T> future; // Future yang bakal dieksekusi
  const Ui(this.future);

  // Fungsi `loading` ini bakal menjalankan future sambil menampilkan toast "Loading..."
  // dan otomatis menghilangkan toast saat future selesai.
  Future<T> loading([String? message, void Function()? onCancel]) async {
    Toast.overlay(message ?? 'Loading...',
        onCancel: onCancel); // Tampilkan loading
    final res = await future; // Tunggu hasil future
    Toast.dismiss(); // Hilangkan loading setelah selesai

    // Kalau hasil future adalah `Response`, cek statusnya
    if (res is Response) {
      if (!res.status) {
        // Kalau gagal, tampilkan pesan error dalam toast
        Toast.error(res.message, maxLength: 150, duration: 4.s);
      }
      return res as T; // Kembalikan response
    }

    return res; // Kalau bukan `Response`, kembalikan hasilnya langsung
  }
}
