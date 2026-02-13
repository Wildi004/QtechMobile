import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';

// anggaplah kita punya 2 user = staff & admin
// staff hanya boleh melihat data produk
// admin hanya boleh melihat data produk, dokumen, galeri
// direktur = bisa melihat semua menu

class MenuItem {
  final String name;
  final IconData icon;
  final String code;

  MenuItem(this.name, this.icon, this.code);
}

class ContohController extends GetxController {
  final List<MenuItem> menus = [
    MenuItem('Karyawan', Hi.userMultiple, 'm-1'),
    MenuItem('Produk', Hi.archive, 'm-2'),
    MenuItem('Dokumen', Hi.files01, 'm-3'),
    MenuItem('Galeri', Hi.image01, 'm-4'),
  ];

  List<MenuItem> displayMenu = [];

  Future getRoles() async {
    try {
      // lakukan request api untuk mendapatkan hak akses user yang sedang login
      // hasil yang diharapkan:

      final roles = {
        'direktur': ['m-1', 'm-2', 'm-3', 'm-4']
      };
      final accesses = roles.values.expand((v) => v).toSet().toList();

      displayMenu = menus.where((e) => accesses.contains(e.code)).toList();
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    getRoles();
    super.onInit();
  }
}

class ContohView extends GetView<ContohController> {
  const ContohView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ContohController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Contoh Menu'),
      ),
      body: LzListView(
        children: [
          ...controller.displayMenu.generate((e, i) {
            return InkTouch(
              onTap: () {
                if (e.name == 'Arsip') {}
              },
              padding: Ei.all(20),
              border: Br.only(['t'], except: i),
              child: Row(
                spacing: 10,
                children: [Icon(e.icon), Text(e.name)],
              ),
            );
          })
        ],
      ),
    );
  }
}

// kalau menu yang ditampilkan diambil dari api, ini lebih mudah, kenapa?
// ketika kita get api menunya, backend sudah bisa memfilter menu apa saja yang diberikan untuk user tersebut

// kamu login sebagai staff, lalu kamu get api menu
// backend kan bisa ngecaba bahwa yang login ini adalah staff
// maka ketika kita get api menu tinggal di filter aja di backend
// jika staff maka berikan menu a, b, c
// jika admin maka berikan menu a, b, c, d, e

// yang kita terima hanya data menu saja, kita gak perlu pusing memfilter berdasarkan role
// karena proses filter itu sudah dilakukan di backend

// api = /menu-regional
final formatMenu = [
  {
    'name': 'BSD',
    'sub_menu': [
      {
        'name': 'IT',
        'sub_menu': [
          {'name': 'Arsip', 'icon': 'icon-1'},
          {'name': 'Aset Elektronik'},
        ]
      }
    ]
  }
];

// api = /menu-favorites
final favorites = [
  {'name': 'Role Access'},
  {'name': 'Validasi Dirut'}
];

// nama icon di library = Hi.name_icon

final icons = {'icon-1': Hi.archive};
// icons[sub_menu.icon]
