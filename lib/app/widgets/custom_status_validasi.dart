import 'package:flutter/material.dart';

String statusValidasiText(int? status) {
  switch (status) {
    case 0:
      return 'Belum';
    case 1:
      return 'Diterima';
    case 2:
      return 'Tolak';
    case 3:
      return '-';
    case 4:
      return 'Cancel';
    default:
      return 'Not Check';
  }
}

Color statusValidasiColor(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    case 3:
      return const Color.fromARGB(255, 255, 0, 0);
    case 4:
      return const Color.fromARGB(255, 255, 0, 0);
    default:
      return Colors.black45;
  }
}

Widget statusValidasiRow(String label, int? status) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '$label ',
        style: const TextStyle(fontSize: 14),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: statusValidasiColor(status),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          statusValidasiText(status),
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    ],
  );
}

Color? statusValidasiCardColor(int? status) {
  if (status == 0) {
    return const Color.fromARGB(255, 159, 0, 21); // Contoh merah soft
  }
  return null; // null = default, pakai bawaan `LzCard`
}

statusValidasiCardColors(int? status) {
  if (status == 0) {
    return const Color.fromARGB(255, 159, 0, 21); // Contoh merah soft
  }
  return null;
}

String statusGM(int? status) {
  switch (status) {
    case 0:
      return 'Belum Divalidasi';
    case 1:
      return 'Sudah Divalidasi';
    case 2:
      return 'Ditolak';
    case 3:
      return '-';
    case 4:
      return 'Cancel';
    default:
      return 'Tidak Diketahui';
  }
}

Color statusColor(int? status) {
  switch (status) {
    case 0:
      return Colors.red;
    case 1:
      return Colors.green;
    case 3:
      return Colors.orange;
    case 4:
      return Colors.grey;
    default:
      return Colors.black45;
  }
}

Widget statusvalidasiGm(String label, int? status) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        '$label :',
        style: const TextStyle(fontSize: 14),
      ),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: statusColor(status),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          statusGM(status),
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    ],
  );
}
