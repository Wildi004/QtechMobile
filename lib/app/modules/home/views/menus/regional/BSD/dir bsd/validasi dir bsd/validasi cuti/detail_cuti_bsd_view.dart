import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/profile_cuti.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20cuti/form_validasi_cuti_bsd_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class DetailCutiBsdView extends GetView<FormValidasiCutiBsdController> {
  final ProfileCuti? data;

  const DetailCutiBsdView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiCutiBsdController());
    final forms = controller.forms;

    if (data != null) {
      final datas = data!.toJson();
      controller.getDetailSudah(data!.id!);
      controller.data = data; // <-- penting!

      forms.fill(datas);
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Validasi Cuti',
        actions: [],
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
                    model: forms.key('user_name'),
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        hint: 'Tanggal Pengajuan',
                        enabled: false,
                        label: 'Tanggal',
                        model: forms.key('tgl_cuti'),
                      ),
                      LzForm.input(
                        label: 'Departemen',
                        enabled: false,
                        model: forms.key('departemen'),
                      ),
                    ],
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        hint: 'Dari',
                        enabled: false,
                        label: 'Dari',
                        model: forms.key('cuti_from'),
                      ),
                      LzForm.input(
                        label: 'Sampai',
                        enabled: false,
                        model: forms.key('cuti_to'),
                      ),
                    ],
                  ),
                  Intrinsic(
                    gap: 10,
                    children: [
                      LzForm.input(
                        enabled: false,
                        label: 'Lama Cuti',
                        maxLines: 3,
                        model: forms.key('lama_cuti'),
                      ),
                      //     LzForm.input(
                      //   enabled: false,
                      //   label: 'Sisa Cuti',
                      //   maxLines: 3,
                      //   model: forms.key('sisa_cuti'),
                      // ),
                    ],
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Perihal',
                    maxLines: 3,
                    model: forms.key('perihal'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Keterangan Cuti',
                    maxLines: 3,
                    model: forms.key('keterangan'),
                  ),
                  LzCard(
                    children: [
                      Row(
                        children: [
                          const Text("Status Dir. BSD : "),
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

                      // Status Dirut
                      Row(
                        children: [
                          const Text("Status HRD : "),
                          Text(
                            getStatusText(data?.statusHrd?.toString()),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color:
                                  getStatusColor(data?.statusHrd?.toString()),
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
