import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/modules/bonus_karyawan/controllers/bonus_karyawan_controller.dart';

class BonusKaryawanView extends StatelessWidget {
  final BonusKaryawanController controller = Get.put(BonusKaryawanController());

  BonusKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("BONUS KARYAWAN",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _buildHeader(context),
          _buildSaldo(context),
          Expanded(child: _buildBonusList(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Colors.blue[800],
      ),
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.04),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: Auth.user(),
              builder: (context, snap) {
                final user = snap.data;
                return SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    user?.name ?? '',
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.height * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                );
              }),
          FutureBuilder(
              future: Auth.user(),
              builder: (context, snap) {
                final user = snap.data;
                return Text(
                  user?.role ?? '',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.height * 0.014,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                );
              }),
        ],
      ),
    );
  }

  Widget _buildSaldo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Container(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient:
              LinearGradient(colors: [Colors.yellow[700]!, Colors.green[400]!]),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("SISA SALDO ANDA",
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white)),
            Obx(() => Text(
                  "Rp. ${controller.saldo.value.toStringAsFixed(0)},-",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Obx(() => ListView(
            children: controller.dataBonus.map((bonus) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: Text(
                        bonus["bulan"] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      trailing: Icon(
                        (bonus["isExpanded"] as RxBool).value
                            ? Icons.keyboard_arrow_down
                            : Icons.keyboard_arrow_right,
                        color: Colors.white,
                      ),
                      onTap: () {
                        (bonus["isExpanded"] as RxBool).value =
                            !(bonus["isExpanded"] as RxBool).value;
                      },
                    ),
                  ),
                  if ((bonus["isExpanded"] as RxBool).value)
                    Column(
                      children: (bonus["items"] as List)
                          .map((item) => _buildBonusItem(item, context))
                          .toList(),
                    ),
                  SizedBox(height: 8),
                ],
              );
            }).toList(),
          )),
    );
  }

  Widget _buildBonusItem(Map<String, dynamic> item, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.width * 0.03),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item["kode"],
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.045,
                      fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Icon(Icons.add_circle_outline,
                      size: MediaQuery.of(context).size.width * 0.044,
                      color: Colors.black54),
                  SizedBox(width: 4),
                  Text("Rp. ${item["nominal"].toStringAsFixed(0)},-",
                      style: TextStyle(color: Colors.black54)),
                ],
              ),
            ],
          ),
          Text(item["tanggal"], style: TextStyle(color: Colors.black54)),
        ],
      ),
    );
  }
}
