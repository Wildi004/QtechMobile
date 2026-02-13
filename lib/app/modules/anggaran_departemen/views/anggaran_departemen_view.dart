import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/anggaran_departemen/controllers/anggaran_departemen_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';
import 'package:fl_chart/fl_chart.dart';
class AnggaranDepartemenView extends StatelessWidget {
  final AnggaranDepartemenController controller =
      Get.put(AnggaranDepartemenController());

  AnggaranDepartemenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppbar(
        title: 'Anggaran Departemen',
         
      ).appBar,
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.025),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: Obx(() {
                bool isLoading = controller.isLoading.value;

                if (isLoading) {
                  return Center(child: CustomLoading());
                }

                bool noData =
    controller.baratChart.isEmpty &&
    controller.pusatChart.isEmpty &&
    controller.timurChart.isEmpty &&
    controller.tengahChart.isEmpty;

if (noData) {
  return Empty(
    message: 'Tidak ada data anggaran.',
    onTap: () => controller.getData(),
  );
}


                return LzListView(
                    padding: Ei.sym(v: 20),
                    onRefresh: () => controller.getData(),
                    onScroll: (scroll) {
                      if (scroll.atBottom(100)) {
                      }
                    },
                    children: [
  AnggaranChart(
    title: "Anggaran Barat (Jakarta)",
    data: controller.baratChart,
  ),
  const SizedBox(height: 40),

  AnggaranChart(
    title: "Anggaran Pusat",
    data: controller.pusatChart,
  ),
  const SizedBox(height: 40),

  AnggaranChart(
    title: "Anggaran Timur (Bali)",
    data: controller.timurChart,
  ),
  const SizedBox(height: 40),

  AnggaranChart(
    title: "Anggaran Tengah",
    data: controller.tengahChart,
  ),
],

                     );
              }),
            ),
          ],
        ),
      ),
    );
  }
}




class AnggaranChart extends StatelessWidget {
  final String title;
  final List data;

  const AnggaranChart({
    super.key,
    required this.title,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),

        SizedBox(
          height: 260,
          child: LineChart(
            LineChartData(
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: true),

              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      int index = value.toInt();
                      if (index >= data.length) return const SizedBox();
                      return Text(data[index].year.toString(), style: const TextStyle(fontSize: 10));
                    },
                  ),
                ),
                leftTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: true),
                ),
              ),

              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  dotData: FlDotData(show: true),
                  spots: List.generate(
                    data.length,
                    (i) => FlSpot(i.toDouble(), data[i].total),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
