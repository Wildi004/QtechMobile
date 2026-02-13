import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/kasbon.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20kasbon/validasi_kasbon_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class ValidasiPtjLegalDetailView extends GetView<ValidasiKasbonController> {
  final Kasbon? data;

  const ValidasiPtjLegalDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ValidasiKasbonController());
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();
      controller.data = data; // <-- penting!

      forms.fill(datas);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Kasbon Detail',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama',
                    model: forms.key('user'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Keperluan',
                    model: forms.key('keterangan'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        hint: 'Tanggal Pengajuan',
                        label: 'Tanggal',
                        model: forms.key('tgl_kasbon'),
                        enabled: false,
                        suffixIcon: Hi.calendar02,
                        onTap: () {
                          LzPicker.date(
                            context,
                            initDate: forms.get('tgl_kasbon').toDate(),
                            onSelect: (date) {
                              forms.set('tgl_kasbon', date.format());
                            },
                          );
                        },
                      ),
                      LzForm.input(
                        label: 'Departemen',
                        enabled: false,
                        model: forms.key('dep'),
                      ),
                    ],
                  ),
                  LzForm.input(
                    label: 'Jumlah',
                    enabled: false,
                    model: forms.key('jml'),
                  ),
                  LzCard(
                    children: [
                      // Status Dir Keuangan
                      Row(
                        children: [
                          const Text("Status Dir Keu : "),
                          Text(
                            getStatusText(data?.statusDirKeuangan?.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(
                                  data?.statusDirKeuangan?.toString()),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),

                      // Status GM
                      Row(
                        children: [
                          const Text("Status GM : "),
                          Text(
                            getStatusText(data?.statusGm?.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: getStatusColor(data?.statusGm?.toString()),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5),

                      // Status Dirut
                      Row(
                        children: [
                          const Text("Status Dirut : "),
                          Text(
                            getStatusText(data?.statusDirut?.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  getStatusColor(data?.statusDirut?.toString()),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Color getStatusColor(String? status) {
  if (status == '1') return Colors.green;
  if (status == '2') return Colors.red;
  return Colors.orange; // 0 = Pending
}

String getStatusText(String? status) {
  if (status == '1') return "ACC";
  if (status == '2') return "Ditolak";
  return "Pending"; // 0
}
