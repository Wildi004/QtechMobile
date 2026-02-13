import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qrm_dev/app/modules/home/controllers/HRD/hrd_absen_controller/laporan_absensi/absensi_seluruh_karyawan_controller.dart';

class SeluruhKaryawanView extends StatelessWidget {
  const SeluruhKaryawanView({super.key});

  @override
  Widget build(BuildContext context) {
    final AbsensiSeluruhKaryawanController controller =
        Get.put(AbsensiSeluruhKaryawanController());

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Obx(() => DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Filter Berdarasakan',
                      border: OutlineInputBorder(),
                    ),
                    value: controller.selectedItem.value == ''
                        ? null
                        : controller.selectedItem.value,
                    items: const [
                      DropdownMenuItem(
                        value: 'satu',
                        child: Text('Pertanggal absensi'),
                      ),
                      DropdownMenuItem(
                        value: 'dua',
                        child: Text('Perbulan absensi'),
                      ),
                      DropdownMenuItem(
                        value: 'tiga',
                        child: Text('Perkaryawan'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.setSelectedItem(value);
                        if (value == 'tiga') {
                          controller.getListUser();
                        }
                      }
                    },
                  )),
              const SizedBox(height: 20),
              Obx(() {
                if (controller.selectedItem.value == 'satu') {
                  return _buildTanggal(controller, context);
                } else if (controller.selectedItem.value == 'dua') {
                  return _buildBulanTahun(controller, context);
                } else if (controller.selectedItem.value == 'tiga') {
                  return _buildKaryawan(controller);
                } else {
                  return const SizedBox.shrink();
                }
              }),
              const SizedBox(height: 20),
              Obx(() => ElevatedButton(
                    onPressed: controller.isSubmitting.value
                        ? null
                        : () {
                            controller.submit();
                          },
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color.fromARGB(255, 0, 0, 0)),
                          )
                        : const Text('Submit'),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTanggal(
      AbsensiSeluruhKaryawanController controller, BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Tanggal Absensi (Y-m-d)',
        border: OutlineInputBorder(),
      ),
      controller: controller.dateController,
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          controller.dateController.text =
              DateFormat('yyyy-MM-dd').format(picked);
        }
      },
    );
  }

  Widget _buildBulanTahun(
      AbsensiSeluruhKaryawanController controller, BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Bulan',
            border: OutlineInputBorder(),
          ),
          value: controller.monthController.text.isNotEmpty
              ? controller.monthController.text
              : null,
          items: List.generate(12, (index) {
            final monthNumber = (index + 1).toString().padLeft(2, '0');
            final monthName = DateFormat.MMMM().format(DateTime(0, index + 1));
            return DropdownMenuItem(
              value: monthNumber,
              child: Text(monthName),
            );
          }),
          onChanged: (value) {
            if (value != null) {
              controller.monthController.text = value;
            }
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Tahun',
            border: OutlineInputBorder(),
          ),
          value: controller.yearController.text.isNotEmpty
              ? controller.yearController.text
              : null,
          items: List.generate(50, (index) {
            final year = (DateTime.now().year - index).toString();
            return DropdownMenuItem(
              value: year,
              child: Text(year),
            );
          }),
          onChanged: (value) {
            if (value != null) {
              controller.yearController.text = value;
            }
          },
        )
      ],
    );
  }

  Widget _buildKaryawan(AbsensiSeluruhKaryawanController controller) {
    if (controller.isLoading.value) {
      return const CircularProgressIndicator();
    }

    if (controller.users.isEmpty) {
      return const Text('Tidak ada data karyawan');
    }

    return DropdownButtonFormField<String>(
      isExpanded: true,
      decoration: const InputDecoration(
        labelText: 'Nama Karyawan',
        border: OutlineInputBorder(),
      ),
      value: controller.selectedUserId.value == ''
          ? null
          : controller.selectedUserId.value,
      items: controller.users.map((user) {
        return DropdownMenuItem(
          value: user.id.toString(),
          child: Text(
            user.name ?? 'Tanpa Nama',
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          controller.selectedUserId.value = value;
        }
      },
    );
  }
}
