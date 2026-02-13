import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/supplier.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Supplier%20Logistik/create_supplier_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateSupplierLogistikView
    extends GetView<CreateSupplierLogistikController> {
  final Supplier? data;
  const CreateSupplierLogistikView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CreateSupplierLogistikController());
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
        appBar: CustomAppbar(
          title: 'Form Supplier',
          actions: [
            IconButton(
              onPressed: () {
                controller.onSubmit(data?.id);
              },
              icon: Icon(Hi.tick04),
            ),
          ],
        ).appBar,
        body: LzListView(
          gap: 10,
          children: [
            LzForm.input(
              label: 'Nama Perusahaan',
              maxLines: 99,
              hint: 'Masukan Nama Perusahaan',
              model: forms.key('nama_perusahaan'),
            ),
            LzForm.input(
              label: 'Contact Person 1',
              hint: 'Masukan Contact Person 1',
              maxLines: 99,
              model: forms.key('cp1'),
            ),
            LzForm.input(
              label: 'Contact Person 2',
              hint: 'Masukan Contact Person 2',
              maxLines: 99,
              model: forms.key('cp2'),
            ),
            LzForm.input(
              label: 'Contact Person 3',
              hint: 'Masukan Contact Person 3',
              maxLines: 99,
              model: forms.key('cp3'),
            ),
            LzForm.input(
              label: 'Email 1',
              hint: 'Masukan Email 1',
              maxLines: 99,
              model: forms.key('email1'),
            ),
            LzForm.input(
              label: 'Email 2',
              hint: 'Masukan Email 2',
              maxLines: 99,
              model: forms.key('email2'),
            ),
            LzForm.input(
              hint: 'Masukan Email 3',
              label: 'Email 3',
              maxLines: 99,
              model: forms.key('email3'),
            ),
            LzForm.input(
              label: 'Alamat',
              hint: 'Masukan Alamat',
              maxLines: 3,
              model: forms.key('alamat'),
            ),
            LzForm.input(
              label: 'No. Telp 1',
              hint: 'Masukan Telp 1',
              maxLines: 99,
              model: forms.key('no_telp1'),
            ),
            LzForm.input(
              label: 'No. Telp 2',
              hint: 'Masukan Telp 2',
              maxLines: 99,
              model: forms.key('no_telp2'),
            ),
            LzForm.input(
              label: 'No. Telp 3',
              hint: 'Masukan Telp 3',
              maxLines: 99,
              model: forms.key('no_telp3'),
            ),
            LzForm.input(
              label: 'No. Fax',
              hint: 'Masukan No. Fax',
              maxLines: 99,
              model: forms.key('no_fax'),
            ),
            LzForm.input(
              maxLines: 99,
              hint: 'Masukan NPWP',
              label: 'NPWP',
              model: forms.key('npwp'),
            ),
            LzForm.input(
              label: 'Bank 1',
              hint: 'Masukan Bank 1',
              maxLines: 99,
              model: forms.key('bank1'),
            ),
            LzForm.input(
              label: 'Bank 2',
              hint: 'Masukan Bank 2',
              maxLines: 99,
              model: forms.key('bank2'),
            ),
            LzForm.input(
              label: 'Bank 3',
              hint: 'Masukan Bank 3',
              maxLines: 99,
              model: forms.key('bank3'),
            ),
            LzForm.input(
              label: 'Rek 1',
              hint: 'Masukan Rek 1',
              maxLines: 99,
              model: forms.key('rek1'),
            ),
            LzForm.input(
              label: 'Rek 2',
              hint: 'Masukan Rek 2',
              maxLines: 99,
              model: forms.key('rek2'),
            ),
            LzForm.input(
              label: 'Rek 3',
              hint: 'Masukan Rek 3',
              maxLines: 99,
              model: forms.key('rek3'),
            ),
          ],
        ));
  }
}
