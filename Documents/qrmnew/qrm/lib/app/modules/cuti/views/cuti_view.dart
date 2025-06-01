import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/data/services/storage/auth.dart';
import 'package:qrm/app/modules/cuti/controllers/cuti_controller.dart';

class CutiView extends GetView<CutiController> {
  const CutiView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CutiController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("CUTI", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              _buildHeader(context),
              Positioned(
                left: 7,
                top: MediaQuery.of(context).size.width * 0.18,
                child: _buildCutiInfo(context),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.2),
          _buildCutiList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.width * 0.28,
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.width * 0.04),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
        color: Colors.blue[800],
      ),
      child: Center(
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
      ),
    );
  }

  Widget _buildCutiInfo(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.width * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(colors: [
                    const Color.fromARGB(255, 171, 167, 161),
                    const Color.fromARGB(255, 108, 192, 137)
                  ]),
                ),
                child: Obx(() {
                  final cuti = controller.cuti.value;
                  return Text.rich(TextSpan(
                    children: [
                      TextSpan(
                        text: "Sisa Cuti Anda ",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      TextSpan(
                        text: "${cuti?.jmlCuti ?? '0'} ",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.055,
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(255, 122, 49, 49)),
                      ),
                      TextSpan(
                        text: "Hari",
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ));
                }),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.04),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.04,
                      horizontal: MediaQuery.of(context).size.width * 0.04),
                  minimumSize: Size(MediaQuery.of(context).size.width * 0.04,
                      MediaQuery.of(context).size.width * 0.04),
                  fixedSize: Size(MediaQuery.of(context).size.width * 0.35,
                      MediaQuery.of(context).size.width * 0.14),
                ),
                onPressed: () {
                  _showFormPengajuan(Get.context!);
                },
                icon: Icon(Icons.add_circle_outline_outlined,
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width * 0.06),
                label: Text("Ajukan",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.width * 0.03),
          Column(
            children: [
              Text(
                "Sisa cuti anda akan di reset kembali pada akhir tahun.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                    color: Colors.black54),
              ),
              Text(
                "Semakin lama anda cuti, semakin banyak potongan Gaji.",
                style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    color: Colors.black54,
                    fontWeight: Fw.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCutiList(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
        child: Obx(() => ListView(
              children: controller.cutiList.map((cuti) {
                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      color: Colors.blue[700],
                      child: ListTile(
                        title: Text(
                          cuti["title"] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        trailing: Icon(
                          (cuti["isExpanded"] as RxBool).value
                              ? Icons.keyboard_arrow_down
                              : Icons.keyboard_arrow_right,
                          color: Colors.white,
                        ),
                        onTap: () {
                          (cuti["isExpanded"] as RxBool).value =
                              !(cuti["isExpanded"] as RxBool).value;
                        },
                      ),
                    ),
                    if ((cuti["isExpanded"] as RxBool).value)
                      Container(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                              vertical:
                                  MediaQuery.of(context).size.width * 0.03),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                spreadRadius: 2,
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Cuti tiga hari",
                                    style: TextStyle(
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                  Text(
                                    "Belum Validasi",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 214, 75, 0),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ],
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.02),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "04 Februari 2025",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                  Text(
                                    "s/d",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                  Text(
                                    "08 Februari 2025",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.04),
                                  ),
                                ],
                              ),
                            ],
                          )),
                    SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  ],
                );
              }).toList(),
            )),
      ),
    );
  }

  void _showFormPengajuan(BuildContext context) {
    final forms = controller.forms;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Form Pengajuan Cuti"),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LzForm.input(
                    label: 'Nama Pemohon',
                    hint: '',
                    model: forms.key('name'),
                    enabled: false),
                SizedBox(height: 10),
                LzForm.input(
                    label: 'Tanggal Pengajuan',
                    hint: '',
                    suffixIcon: Hi.calendar02,
                    onTap: () {
                      LzPicker.date(context,
                          minDate: now.subtract(70.y),
                          maxDate: now,
                          initDate: forms.get('tgl_lahir').toDate(),
                          onSelect: (date) {
                        forms.set('tgl_lahir', date.format());
                      });
                    }),
                SizedBox(height: 10),
                LzForm.input(
                  label: 'Perihal Cuti',
                  hint: '',
                  maxLength: 19,
                ),
                LzForm.input(
                  label: 'Keterangan',
                  hint: '',
                  maxLength: 19,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller.dariController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Dari",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () =>
                                controller.selectDate(Get.context!, true),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: controller.sampaiController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Sampai",
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () =>
                                controller.selectDate(Get.context!, false),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
              ),
              onPressed: () {
                Navigator.pop(context);
                Get.snackbar("Sukses", "Pengajuan cuti berhasil dikirim",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white);
              },
              child: Text("KIRIM", style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
