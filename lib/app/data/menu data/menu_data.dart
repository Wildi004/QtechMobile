// lib/data/menu_data.dart

import 'package:flutter/material.dart';

class MenuData {
  static final List<Map<String, dynamic>> defaultFavorites = [
    {
      'label': 'Kasbon',
      'color': '5D688A',
      'icon': Icons.note,
      'route': 'kasbon',
    },
    {
      'label': 'Capaian Kinerja',
      'color': '4CA1AF',
      'icon': Icons.show_chart,
      'route': 'capaian_kinerja',
    },
    {
      'label': 'Modal Logistik',
      'color': '9f68dd',
      'icon': Icons.note_alt,
      'route': 'modal_logistik',
    },
    {
      'label': 'Notulen',
      'color': '467bf6',
      'icon': Icons.attach_file,
      'route': 'notulen',
    },
  ];

  static final List<Map<String, dynamic>> otherMenus = [
    {
      'label': 'Anggaran Departemen',
      'icon': Icons.account_balance,
      'color': Colors.deepPurple,
      'route': 'anggaran_departemen',
    },
    {
      'label': 'Monitoring Project',
      'icon': Icons.monitor,
      'color': Colors.indigo,
      'route': 'monitoring_project',
    },
    {
      'label': 'Panduan Instalasi',
      'icon': Icons.help,
      'color': Colors.lightGreen,
      'route': 'panduan_instalasi',
    },
  ];
}
