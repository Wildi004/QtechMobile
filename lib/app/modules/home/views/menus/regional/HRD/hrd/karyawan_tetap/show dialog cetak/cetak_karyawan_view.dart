import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CetakKaryawanView extends StatelessWidget {
  final List<String> statusList;

  const CetakKaryawanView({super.key, required this.statusList});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Pilih Status Karyawan',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: statusList.map((status) {
            return InkWell(
              onTap: () => Navigator.pop(context, status),
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                ),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      status.capitalizeFirst ?? '',
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
