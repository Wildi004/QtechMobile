import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rj/validasi_rbp_rj_sudah_controller.dart';
import 'package:qrm_dev/app/widgets/custom_loading.dart';

class ValRbpRjInformasiUmumView extends GetView<ValidasiRbpRjSudahController> {
  final String? noHide;

  const ValRbpRjInformasiUmumView({
    super.key,
    this.noHide,
  });

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (noHide != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await controller.getDetailByNoHide(noHide!);

        if (controller.detailDatas.isNotEmpty) {
          final data = controller.detailDatas.first;

          forms.set('judul_kontrak', data.proyek?.judulKontrak ?? '');
          forms.set('no_kontrak', data.proyek?.noKontrak ?? '');
          forms.set('tgl_kontrak', data.proyek?.tglKontrak ?? '');
          forms.set('area_proyek', data.proyek?.areaProyek ?? '');
          forms.set('durasi_kontrak', data.proyek?.durasiKontrak ?? '');
          forms.set('durasi_proyek', data.proyek?.durasiProyek ?? '');
          forms.set('lokasi_proyek', data.proyek?.lokasiProyek ?? '');

          forms.set('vendor', data.proyek?.vendor ?? '');
          forms.fill(data.toJson());
        }
      });
    }

    return Obx(() {
      if (controller.isDetailLoading.value) {
        return CustomLoading();
      }

      if (controller.detailDatas.isEmpty) {
        return const Center(child: Text("Data tidak ditemukan"));
      }

      return SingleChildScrollView(
        padding: Ei.only(t: 10),
        child: Column(
          crossAxisAlignment: Caa.start,
          children: [
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  enabled: false,
                  label: 'Kode RBP',
                  model: forms.key('kode_rbp'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Kode Proyek',
                  model: forms.key('kode_proyek'),
                ),
              ],
            ),
            LzForm.input(
              enabled: false,
              maxLines: 99,
              label: 'No Kontrak',
              model: forms.key('no_kontrak'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  enabled: false,
                  label: 'Area Proyek',
                  model: forms.key('area_proyek'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Tanggal Kontrak',
                  model: forms.key('tgl_kontrak'),
                ),
              ],
            ),
            LzForm.input(
              enabled: false,
              label: 'Nilai Kontrak',
              model: forms.key('nilai_kontrak'),
            ),
            LzForm.input(
              enabled: false,
              label: 'Judul Kontrak',
              maxLines: 99,
              model: forms.key('judul_kontrak'),
            ),
            Intrinsic(
              gap: 10,
              children: [
                LzForm.input(
                  enabled: false,
                  label: 'Durasi Proyek',
                  model: forms.key('durasi_proyek'),
                ),
                LzForm.input(
                  enabled: false,
                  label: 'Durasi Kontrak',
                  model: forms.key('durasi_kontrak'),
                ),
              ],
            ),
            LzForm.input(
              enabled: false,
              label: 'Lokasi Proyek',
              model: forms.key('lokasi_proyek'),
            ),
            LzForm.input(
                enabled: false,
                label: 'Perusahaan Pemberi Kerja Area Proyek',
                model: forms.key('vendor'),
                maxLines: 99),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pekerjaan :',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                // mapping dengan index
                ...?controller.detailDatas.first.proyek?.dataProyekItem
                    ?.asMap()
                    .entries
                    .map(
                  (entry) {
                    final index = entry.key + 1; // mulai dari 1
                    final item = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: LzCard(
                        children: [
                          Text(
                            '$index.',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const Divider(),
                          _buildBoldText('PM', item.pmName),
                          _buildBoldText('SEM', item.semName),
                          _buildBoldText('SOM', item.somName),
                          _buildBoldText('SPV', item.spvName),
                          _buildBoldText('Pekerjaan', item.uraianPekerjaan),
                          _buildBoldText('Vol', item.volume),
                          _buildBoldText('Harga Satuan', item.hargaSatuan),
                          _buildBoldText('Total Harga', item.jmlHarga),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),

            /// helper widget supaya lebih rapi
          ],
        ),
      );
    });
  }
}

Widget _buildBoldText(String title, dynamic value) {
  return Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: '$title: ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        TextSpan(
          text: value?.toString() ?? '-',
        ),
      ],
    ),
  );
}
