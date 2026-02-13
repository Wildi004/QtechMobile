import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/saldo.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_saldo_controller/create_saldo_controller.dart';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class CreateSaldoView extends GetView<CreateSaldoController> {
  final Saldo? data;

  const CreateSaldoView({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final forms = controller.forms;

    if (data != null) {
      forms.fill(data!.toJson());
      forms.set('dep', data!.dep ?? '');
    } else {
      forms.set('dep', 'BSD');
    }

    return Scaffold(
      appBar: CustomAppbar(
        title: 'Form Distribusi Saldo',
        actions: [
          IconButton(
            onPressed: () {
              controller.onSubmit(data?.id);
            },
            icon: Icon(Hi.tick03),
          )
        ],
      ).appBar,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LzForm.input(
              label: 'Saldo Akhir',
              model: forms.key('saldo_akhir'),
              enabled: false,
            ),
            14.height,
            LzForm.input(
              hint: 'Keterangan',
              label: 'Keterangan',
              model: forms.key('keterangan'),
            ),
            14.height,
            LzForm.input(
              hint: 'Departemen',
              label: 'Departemen',
              model: forms.key('dep'),
              enabled: false,
            ),
            14.height,
            LzForm.input(
              label: 'Tanggal Terima',
              hint: 'Format: YYYY-MM-DD',
              model: forms.key('tgl_terima'),
              suffixIcon: Hi.calendar02,
              onTap: () {
                LzPicker.date(context,
                    minDate: DateTime(1900),
                    initDate: forms.get('tgl_terima').toDate(),
                    onSelect: (date) {
                  forms.set('tgl_terima', date.format());
                });
              },
            ),
            14.height,
            LzForm.input(
              hint: 'Jumlah',
              label: 'Jumlah',
              model: forms.key('kredit'),
            ),
          ],
        ),
      ),
    );
  }
}

//   Future onSubmit([int? id]) async {
//   try {
//     final form = forms.validate();

//     logg('=== START onSubmit ===');
//     logg('Selected dep_ids: $selectedDepIds');

//     if (selectedDepIds.isEmpty) {
//       Toast.show('Pilih departemen dulu');
//       return;
//     }

//     if (file == null) {
//       Toast.show('Pilih file dulu');
//       return;
//     }

//     if (form.ok) {
//       final auth = await Auth.user();
//       logg('Authenticated User ID: ${auth.id}');

//       final formData = dio.FormData.fromMap({
//         'perihal': form.value['perihal'],
//         'tgl_surat': form.value['tgl_surat'],
//         'sifat': form.value['sifat'],
//         'image': await dio.MultipartFile.fromFile(
//           file!.path,
//           filename: fileName.value,
//         ),
//         'keterangan': form.value['keterangan'],
//         'user_id': auth.id,
//         'dep_id[]': selectedDepIds
//       });

//       logg('=== REQUEST INFO ===');
//       logg('URL: https://laravel.apihbr.link/api/surat/keluar/departemen');
//       logg('Headers: Content-Type: multipart/form-data');
//       logg('FormData fields: ${formData.fields}');
//       logg('FormData files: ${formData.files}');

//       // Jalankan request
//       final res = await dio.Dio().post(
//         'https://laravel.apihbr.link/api/surat/keluar/departemen',
//         data: formData,
//         options: dio.Options(
//           headers: {
//             'Content-Type': 'multipart/form-data',
//           },
//         ),
//       );

//       logg('=== RESPONSE ===');
//       logg('Status Code: ${res.statusCode}');
//       logg('Data: ${res.data}');

//       if (res.statusCode == 200) {
//         Get.back(result: res.data);
//         Get.snackbar('Berhasil', res.data['message'].toString());
//       } else {
//         logg('Unexpected status code: ${res.statusCode}');
//       }
//     } else {
//       logg('Form is not valid');
//     }
//     logg('=== END onSubmit ===');
//   } catch (e, s) {
//     logg('=== ERROR ===');
//     logg('Error: $e');
//     logg('Stack: $s');
//     Errors.check(e, s);
//   }
// }
