import 'dart:io';

import 'package:get/get.dart' hide Bindings;
import 'package:image_picker/image_picker.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/karyawan_tetap.dart';
import 'package:qrm_dev/app/data/services/storage/auth.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_karyawan_tetap_controller/karyawan_tetap_controller.dart';

class EditTtdKaryawanTetapController extends GetxController with Apis {
  RxInt tab = 0.obs;
  File? file;
  XFile? fileImage;
  RxString fileName = ''.obs;
  RxList<KaryawanTetap> karyawanTetap = <KaryawanTetap>[].obs;

  KaryawanTetap getKaryawan(int? id) {
    return karyawanTetap.firstWhere((e) => e.id == id,
        orElse: () => KaryawanTetap());
  }

  XFile? fileTtd;
  KaryawanTetap? details;
  RxBool isLoading = true.obs;
  final forms = LzForm.make([
    "name",
    "no_induk",
    "golongan",
    "prosentase",
    "no_ktp",
    "email",
    "no_telp",
    "image",
    "role_id",
    "dept_id",
    "regional",
    "regional_ktp",
    'alamat_ktp',
    'alamat_domisili',
    'tempat_lahir',
    'tgl_lahir',
    'gender',
    'agama',
    'status_kawin_id',
    'tgl_bergabung',
    'is_active',
    'shift_id',
    'building_id',
    'ttd',
    'status_karyawan',
    'id_telegram',
  ]);

  Future getDetailUser(int id) async {
    try {
      Bindings.onRendered(() async {
        Toast.overlay('Loading...', onCancel: () {});

        if (details == null) {
          final res = await api.karyawanTetap.getDataDetail(id);
          details = KaryawanTetap.fromJson(res.data ?? {});
        }

        forms.fill(details!.toJson());

        Toast.dismiss();
      });
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  Future onSubmitTtd([int? id]) async {
    try {
      final form = forms.validate(required: ['ttd']);
      if (form.ok) {
        final auth = await Auth.user();
        final payload = form.value;

        payload['user_id'] = auth.id;

        if (file != null) {
          payload['ttd'] = await api.toFile(file!.path);
        }

        if (id == null) {
          final res = await api.karyawanTetap
              .createData(payload)
              .ui
              .loading('Menambahkan...');
          if (res.status) {
            Get.back(result: res.data);
            Get.snackbar('Berhasil', res.message.toString());
          }
        } else {
          final res = await api.karyawanTetap
              .updateTtd(payload, id)
              .ui
              .loading('Memperbarui...');
          if (res.status) {
            Get.back(result: res.data); // res.data itu Map<String, dynamic>
            // <-- ini yang dipakai di atas
            Toast.success('Data berhasil diperbarui, silahkan refresh');
          }
        }
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  void updateData(KaryawanTetap data, int id) {
    try {
      final employee = Get.find<KaryawanTetapController>();

      int index = employee.listkaryawan.indexWhere((e) => e.id == id);
      logg('updateing... $index');
      if (index >= 0) {
        employee.listkaryawan[index] = data;
        employee.isLoading.refresh();
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

//  'kode_rbp',
//     'kode_proyek',
//     'total_material_utama',
//     'total_material_tambahan',
//     'total_upah_tk',
//     'total_by_alat_utama',
//     'total_by_alat_tambahan',
//     'total_biaya_akomodasi',
//     'total_beban_proyek',
//     'nilai_kontrak',
//     'nilai_pendapatan_95',
//     'm_fee_kantor',
//     'k_fee_kantor',
//     'pph',
//     'dpp_pph',
//     'ppn',
//     'scf',
//     'netto',
//     'estimasi_laba',
//     'retensi',
//     'prestasi_laba',
//     'prepared_by',
//     'status_pm',
//     'validasi_pm',
//     'status_gm',
//     'validasi_gm',
//     'status_dirtek',
//     'validasi_dirtek',
//     'status_bsd',
//     'validasi_bsd',
//     'approval',
//     'status_dir_keuangan',
//     'approved_by',
//     'status_dir_utama',
//     'created_at',
//     'no_hide_rbp',
//     'validasi_pm_name',
//     'validasi_gm_name',
//     'validasi_dirtek_name',
//     'validasi_bsd_name',
//     'approval_name',
//     'approved_by_name',

//     // proyek nested
//     'id',
//     'kode_proyek',
//     'status_proyek',
//     'man_fee_kantor',
//     'kom_fee_kantor',
//     'nilai_pph',
//     'pot_pph',
//     'sisa_pot_pph',
//     'nilai_ppn',
//     'nilai_ref',
//     'nilai_scf',
//     'dpp_pendapatan',
//     'no_kontrak',
//     'tgl_kontrak',
//     'judul_kontrak',
//     'nilai_kontrak',
//     'durasi_kontrak',
//     'durasi_proyek',
//     'lokasi_proyek',
//     'nama_pemberi_kerja',
//     'jumlah_total',
//     'diskon',
//     'jml_diskon',
//     'harga_setelah_diskon',
//     'keuntungan',
//     'jml_keuntungan',
//     'harga_setelah_keuntungan',
//     'dibulatkan',
//     'ppn_total',
//     'grand_total',
//     'created_by',
//     'no_hide',
//     'created_at',
//     'keterangan',
//     'area_proyek',
//     'jenis_proyek',
//     'jenis_kontrak',
//     'provinsi',
//     'vendor',

// // material utama
//     'id',
//     'kode_rbp',
//     'kode_proyek',
//     'no_hide_rbp',
//     'uraian_mu',
//     'jumlah_mu',
//     'satuan_id_mu',
//     'harga_modal',
//     'total_harga_mu',
//     'created_at',
//     'satuan',
