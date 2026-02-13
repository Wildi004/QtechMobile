import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/supplier.dart';
import 'package:qrm_dev/app/modules/home/controllers/LOGISTIK/Supplier%20Logistik/supplier_logistik_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class SupplierLogistikDetailView extends GetView<SupplierLogistikController> {
  final Supplier? data;

  const SupplierLogistikDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Supplier',
      ).appBar,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            Expanded(
              child: LzListView(
                autoCache: true,
                gap: 10,
                children: [
                  LzForm.input(
                    enabled: false,
                    label: 'Nama Perusahaan',
                    maxLines: 99,
                    model: forms.key('nama_perusahaan'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Contact Person 1',
                    maxLines: 99,
                    model: forms.key('cp1'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Contact Person 2',
                    maxLines: 99,
                    model: forms.key('cp2'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Contact Person 3',
                    maxLines: 99,
                    model: forms.key('cp3'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Email 1',
                    maxLines: 99,
                    model: forms.key('email1'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Email 2',
                    maxLines: 99,
                    model: forms.key('email2'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Email 3',
                    maxLines: 99,
                    model: forms.key('email3'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Alamat',
                    maxLines: 3,
                    model: forms.key('alamat'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No. Telp 1',
                    maxLines: 99,
                    model: forms.key('no_telp1'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No. Telp 2',
                    maxLines: 99,
                    model: forms.key('no_telp2'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No. Telp 3',
                    maxLines: 99,
                    model: forms.key('no_telp3'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'No. Fax',
                    maxLines: 99,
                    model: forms.key('no_fax'),
                  ),
                  LzForm.input(
                    enabled: false,
                    maxLines: 99,
                    label: 'NPWP',
                    model: forms.key('npwp'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Bank 1',
                    maxLines: 99,
                    model: forms.key('bank1'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Bank 2',
                    maxLines: 99,
                    model: forms.key('bank2'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Bank 3',
                    maxLines: 99,
                    model: forms.key('bank3'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
