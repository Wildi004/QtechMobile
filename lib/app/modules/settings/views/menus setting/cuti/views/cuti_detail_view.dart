import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/hrd_cuti.dart';
import 'package:qrm_dev/app/modules/settings/views/menus%20setting/cuti/controllers/cuti_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/custom_decoration.dart';

import '../../../../../home/views/menus/regional/BSD/dir bsd/validasi dir bsd/validasi cuti/validasi_cuti_belum_validasi_view.dart';

class CutiDetailView extends GetView<CutiController> {
  final HrdCuti? data;

  const CutiDetailView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Detail Cuti',
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
                    maxLines: 999,
                    model: forms.key('user_name'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Tanggal Pengajuan',
                    maxLines: 999,
                    model: forms.key('tgl_cuti'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Perihal',
                    maxLines: 999,
                    model: forms.key('perihal'),
                  ),
                  LzForm.input(
                    enabled: false,
                    label: 'Departemen',
                    maxLines: 999,
                    model: forms.key('departemen'),
                  ),
                  Intrinsic(gap: 10, children: [
                    LzForm.input(
                      enabled: false,
                      label: 'Dari',
                      model: forms.key('cuti_from'),
                    ),
                    LzForm.input(
                      enabled: false,
                      label: 'Sampai',
                      model: forms.key('cuti_to'),
                    ),
                  ]),
                  LzForm.input(
                    enabled: false,
                    label: 'Lama Cuti',
                    model: forms.key('lama_cuti'),
                  ),
                  LzForm.input(
                    enabled: false,
                    maxLines: 999,
                    label: 'Keterangan Cuti',
                    model: forms.key('keterangan'),
                  ),
                  20.height,
                  Intrinsic(children: [
                    Text(
                      'Validasi HRD :',
                      style: CustomTextStyle.title(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Validasi Dir. BSD :',
                      style: CustomTextStyle.title(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  Intrinsic(children: [
                    Text(
                      statusText(data?.statusHrd),
                      style: CustomTextStyle.subtitle(
                        color: statusBgColor(data?.statusHrd),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      statusText(data?.statusDirKeuangan),
                      style: CustomTextStyle.subtitle(
                        color: statusBgColor(data?.statusDirKeuangan),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
                  20.height,
                  LzCard(
                    children: [
                      Text(
                          'Note : Jumlah Sisa Cuti akan berubah jika pengajuan cuti sudah divalidasi oleh Dir.Keuangan. Jika pengajuan cuti di ACC maka sisa jumlah cuti akan berkurang sesuai dengan lama cuti yang di ajukan.'),
                    ],
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
