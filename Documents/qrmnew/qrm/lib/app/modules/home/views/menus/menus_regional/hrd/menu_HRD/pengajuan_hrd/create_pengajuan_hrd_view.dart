import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:qrm/app/modules/home/controllers/HRD/hrd_pengajuan_controller/create_pengajuan_hrd_controller.dart';

class CreatePengajuanHrdView extends StatelessWidget {
  CreatePengajuanHrdView({super.key});

  final controller = Get.put(CreatePengajuanHrdController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                controller.updatePengajuan();
              } else {
                Get.snackbar('Error', 'Mohon isi semua data dengan benar');
              }
            },
            icon: Icon(Hi.tick04),
            color: Colors.white,
          )
        ],
        title: const Text('Form Pengajuan Dana',
            style: TextStyle(color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF4CA1AF), Color(0xFF808080)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: controller.noPengajuan,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'No Pengajuan',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: controller.tglPengajuan,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Tanggal Pengajuan',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: controller.departemen,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Departemen',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: LzListView(padding: EdgeInsets.zero, children: [
                  Obx(() => Column(
                        children: [
                          ...List.generate(controller.tambahanList.length,
                              (index) {
                            final item = controller.tambahanList[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Data ${index + 1}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      IconButton(
                                        onPressed: () =>
                                            controller.removeForm(index),
                                        icon: const Icon(Hi.cancel02,
                                            color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: item['field1'],
                                    readOnly: true,
                                    decoration: const InputDecoration(
                                      labelText: 'Tanggal',
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Hi.calendar02),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Tanggal wajib diisi';
                                      }
                                      return null;
                                    },
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                      );
                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('yyyy-MM-dd')
                                                .format(pickedDate);
                                        item['field1']!.text = formattedDate;
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  TextFormField(
                                    controller: item['field2'],
                                    decoration: const InputDecoration(
                                      labelText: 'Nama Barang',
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Nama barang wajib diisi';
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: TextFormField(
                                          controller: item['field3'],
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: 'Jumlah',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Jumlah wajib diisi';
                                            }
                                            if (int.tryParse(value) == null) {
                                              return 'Jumlah harus angka';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: TextFormField(
                                          controller: item['field4'],
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: 'Harga Satuan',
                                            border: OutlineInputBorder(),
                                          ),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Harga wajib diisi';
                                            }
                                            if (int.tryParse(value) == null) {
                                              return 'Harga harus angka';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                          LzButton(
                            text: 'Tambah',
                            onTap: () => controller.tambahFormBaru(),
                          ).margin(all: 20),
                          const SizedBox(height: 24),
                        ],
                      )),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
