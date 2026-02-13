import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/del_pemb_non_ppn/del_pemb_non_ppn.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20logistik%20bali/validasi%20del%20pemb%20non%20ppn/form_validasi_del_pemb_non_ppn_controller.dart';

class FormValidasiDelPembNonPpnView
    extends GetView<FormValidasiDelPembNonPpnController> {
  final DelPembNonPpn? data;
  const FormValidasiDelPembNonPpnView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => FormValidasiDelPembNonPpnController());

    if (data != null) {
      controller.data = data;
    }

    return AlertDialog(
      backgroundColor: Color(0xFFF1F1F1),
      contentPadding: const EdgeInsets.all(20),
      title: const Text(
        'Validasi Delivery Pembelian Non PPN',
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
