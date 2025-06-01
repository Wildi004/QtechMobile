import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/capaian_kinerja/controllers/capaian_controller.dart';
import 'package:qrm/app/modules/capaian_kinerja/views/capaian/detail/informasi.dart';

class CapaianView extends StatelessWidget {
  final CapaianController controller = Get.put(CapaianController());

  CapaianView({super.key});

  final List<Color> gradientColors = const [
    Color.fromARGB(255, 54, 145, 220),
    Color.fromARGB(255, 73, 173, 255),
    Color.fromARGB(255, 14, 63, 210),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Capaian Kinerja',
            style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final capaian = controller.capaian;

        return LzListView(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DepartemenBox(
                  title: 'IT',
                  data: capaian.it,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'HRD',
                  data: capaian.hrd,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Legal',
                  data: capaian.legal,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Logistik',
                  data: capaian.logistik,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'GM.Timur',
                  data: capaian.gmTimur,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'GM.Barat',
                  data: capaian.gmBarat,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Finance Pusat',
                  data: capaian.financePusat,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Finance Timur',
                  data: capaian.financeTimur,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Finance Barat',
                  data: capaian.financeBarat,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Sales Timur',
                  data: capaian.salesTimur,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Sales Barat',
                  data: capaian.salesBarat,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Project Timur',
                  data: capaian.projectTimur,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Project Barat',
                  data: capaian.projectBarat,
                  gradientColors: gradientColors),
              DepartemenBox(
                  title: 'Teknik',
                  data: capaian.teknik,
                  gradientColors: gradientColors),
            ],
          ).gap(10)
        ]);
      }),
    );
  }
}

class DepartemenBox extends StatelessWidget {
  final String title;
  final dynamic data;
  final List<Color> gradientColors;

  const DepartemenBox({
    super.key,
    required this.title,
    required this.data,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (data?.data != null) {
          Get.to(() => Informasi(data: data.data));
        }
      },
      child: Container(
        height: 60,
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
