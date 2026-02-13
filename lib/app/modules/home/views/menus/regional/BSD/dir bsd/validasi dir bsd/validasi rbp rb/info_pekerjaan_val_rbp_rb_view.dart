import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb/proyek.dart';
import 'package:qrm_dev/app/data/models/model%20logistik/rbp_rb/rbp_rb.dart';
import 'package:qrm_dev/app/modules/home/controllers/BSD/Validasi%20Dir%20BSD/validasi%20rbp%20rb/validasi_rbp_rb_belum_controller.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/create_validasi_rbp_rb_view.dart';
import 'package:qrm_dev/app/modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20rbp%20rb/validasi_rbp_rb_detail_view.dart';

class InfoPekerjaanValRbpRbView extends StatelessWidget {
  final ProyekRbp? proyek;
  final RbpRb? data;

  const InfoPekerjaanValRbpRbView({super.key, this.proyek, this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Ei.only(b: 20, l: 10, r: 10),
      child: Column(
        children: [
          LzCard(
            children: [
              Text(
                'Judul Kontrak : ',
                style: GoogleFonts.poppins().copyWith(
                  fontWeight: Fw.bold,
                ),
              ),
              Text(proyek?.judulKontrak ?? '-', style: GoogleFonts.poppins()),
              10.height,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Durasi Proyek : ",
                      style:
                          GoogleFonts.poppins().copyWith(fontWeight: Fw.bold),
                    ),
                    TextSpan(text: '${proyek?.durasiKontrak ?? 0} Hari'),
                  ],
                ),
              ),
              10.height,
              Text(
                'Lokasi Proyek : ',
                style: GoogleFonts.poppins().copyWith(fontWeight: Fw.bold),
              ),
              Text(proyek?.lokasiProyek ?? '-'),
              10.height,
              Text(
                'Pemberi Kerja : ',
                style: GoogleFonts.poppins().copyWith(fontWeight: Fw.bold),
              ),
              Text(proyek?.namaPemberiKerja ?? '-'),
              10.height,
              ValidasiRow(label: 'Validasi PM', status: data?.statusPm),
              ValidasiRow(label: 'Validasi GM', status: data?.statusGm),
              ValidasiRow(label: 'Validasi DirTek', status: data?.statusDirtek),
              InkWell(
                  onTap: () {
                    Get.dialog(
                      CreateValidasiRbpRbView(data: data),
                    ).then((value) {
                      if (value == true) {
                        // pindah tab

                        final belum = Get.find<ValidasiRbpRbBelumController>();
                        belum.listData.removeWhere((e) => e.id == data!.id);
                      }
                    });
                  },
                  child: ValidasiRow(
                      label: 'Validasi BSD', status: data?.statusBsd)),
              ValidasiRow(
                  label: 'Validasi Dir. Keu', status: data?.statusDirKeuangan),
              ValidasiRow(
                  label: 'Validasi Dirut', status: data?.statusDirUtama),
              Text('Setting'),
              PopupMenuButton<String>(
                color: Colors.white,
                icon: Icon(Hi.leftToRightListBullet),
                offset: const Offset(40, -10),
                onSelected: (value) {
                  if (value == 'info') {
                    Get.to(
                        () => ValidasiRbpRbDetailView(noHide: data?.noHideRbp));
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "info",
                    child: SizedBox(
                      child: Row(
                        children: [
                          Icon(Hi.settings02, size: 18),
                          SizedBox(width: 8),
                          Text(
                            "Info",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Divider(
            color: Colors.grey.shade700,
            thickness: 1,
          ),
        ],
      ),
    );
  }
}

class ValidasiRow extends StatelessWidget {
  final String label;
  final int? status;

  const ValidasiRow({super.key, required this.label, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label : ',
          style: GoogleFonts.poppins().copyWith(
            fontWeight: Fw.bold,
          ),
        ),
        Text(
          getStatusText(status),
          style: GoogleFonts.poppins().copyWith(
            color: getStatusColor(status),
          ),
        ),
        10.height,
      ],
    );
  }
}

Color getStatusColor(int? status) {
  switch (status) {
    case 0:
      return Colors.orange;
    case 1:
      return Colors.green;
    case 2:
      return Colors.red;
    default:
      return Colors.grey;
  }
}

String getStatusText(int? status) {
  switch (status) {
    case 0:
      return 'Belum Validasi';
    case 1:
      return 'Sudah Validasi';
    case 2:
      return 'Ditolak';
    default:
      return 'Tidak Diketahui';
  }
}
