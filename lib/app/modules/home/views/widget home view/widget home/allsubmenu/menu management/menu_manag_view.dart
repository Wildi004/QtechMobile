// import 'package:flutter/material.dart';
// import 'package:lazyui/lazyui.dart';

// class MenuManagView {
//   static final Map<String, IconData> _icons = {
//     // Dashboard
//     'Dashboard': Hi.home01,
//     'Dashboard Umum': Hi.home01,
//     'Dashboard Dirut': Hi.home01,
//     'Dashboard Dir. Teknik': Hi.user,
//     'Dashboard BSD Eks': Hi.home01,
//     'Dashboard HRD': Hi.home01,
//     'Dashboard Finance Pusat': Hi.home01,

//     // Surat
//     'Surat Masuk': Hi.mail01,
//     'Surat Keluar': Hi.mailAdd01,
//     'Surat Keluar GM Jakarta': Hi.mailAccount01,
//     'Surat Internal': Hi.mailOpen,

//     // Arsip
//     'Arsip Direktur Utama': Hi.money01,
//     'Arsip Direktur Teknik': Hi.money01,
//     'Arsip Dep BSD': Hi.money01,
//     'Arsip GM Jakarta': Hi.money01,

//     // Validasi
//     'Validasi Dirut': Hi.notEqualSign,
//     'Validasi Dir. Teknik': Hi.notEqualSign,
//     'Validasi GM Jakarta': Hi.notEqualSign,
//     'Validasi BSD': Hi.notEqualSign,

//     // Pengajuan
//     'Pengajuan BSD': Hi.fileDollar,
//     'Pengajuan Regional': Hi.fileDollar,

//     // Keuangan
//     'Saldo BSD': Hi.file01,
//     'Saldo Regional Jakarta': Hi.file01,
//     'Anggaran Departemen': Hi.file01,

//     // Lain-lain
//     'Notulen': Hi.file01,
//     'SK Direksi': Hi.identification,
//     'Job Desk': Hi.file01,
//     'Capaian Kinerja': Hi.file01,
//     'Monitoring Proyek': Hi.file01,
//     'Company Profile': Hi.file01,
//     'User Log': Hi.file01,
//     'Role Access': Hi.file01,
//     'Enroll User': Hi.file01,
//   };

//   static IconData get(String? name) {
//     if (name == null) return Hi.grid;
//     return _icons[name] ?? Hi.grid;
//   }
// }
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class MenuManagView {
  static dynamic get(String? name) {
    if (name == null) return Hi.files01;

    final icons = {
      'Dashboard Umum': 'assets/images/grid01.png',
      'Anggaran Departemen': 'assets/images/handMoney.png',
      'Monitoring Proyek': 'assets/images/monitorSeo.png',
      'Dashboard': 'assets/images/grid01.png',
      'Role Access': 'assets/images/keyring.png',
      'User Log': 'assets/images/fileLog.png',
      'Company Profile': 'assets/images/building.png',
      'More': 'assets/images/moreSquare.png',
      'Menu BSD': 'assets/images/grid01.png',
      'Dashboard BSD Eks': 'assets/images/grid01.png',
      'Dashboard Dir. Teknik': 'assets/images/grid01.png',
      'Dashboard Dirut': 'assets/images/grid01.png',
    };
    return icons[name] ?? Hi.files01;
  }
}

Widget buildMenuIcon(String? name, {double size = 35}) {
  final icon = MenuManagView.get(name);

  if (icon is IconData) {
    return Icon(icon, size: size);
  }

  if (icon is String && (icon.endsWith('.png') || icon.endsWith('.jpg'))) {
    return Image.asset(icon, width: size, height: size);
  }

  return Icon(Hi.files01, size: size);
}
