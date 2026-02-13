import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/surat_jalan_exst_non/surat_jalan_exst_non.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20logistik%20bali/validasi%20surat%20jalan%20eksternal%20non%20ppn%20bali/form_validasi_sj_ekst_non_bali_controller.dart';

class FormValidasiSjEksNonBaliView
    extends GetView<FormValidasiSjEkstNonBaliController> {
  final SuratJalanExstNon? data;
  const FormValidasiSjEksNonBaliView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiSjEkstNonBaliController());

    if (data != null) {
      controller.data = data;
    }

    return AlertDialog(
      backgroundColor: Color(0xFFF1F1F1),
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Validasi Surat Jalan Eksternal Non PPN Bali',
        style: TextStyle(fontWeight: Fw.bold),
      ),
      content: StatefulBuilder(
        builder: (context, setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LzForm.select(
                label: 'Kesimpulan Validasi',
                style: OptionPickerStyle(withSearch: true),
                hint: 'Pilih Kesimpulan Validasi',
                model: controller.forms.key('kesimpulan_status_validasi'),
                onTap: () async {
                  final data = await controller.getFinal().overlay();
                  controller.forms
                      .set('kesimpulan_status_validasi')
                      .options(data.labelValue('name', 'id'));
                },
              ),
              SizedBox(height: 20),
              LzButton(
                text: data == null ? 'Submit' : 'Update',
                onTap: () {
                  controller.onSubmit(data?.noHide);
                },
              ).margin(all: 20),
            ],
          );
        },
      ),
    );
  }
}
