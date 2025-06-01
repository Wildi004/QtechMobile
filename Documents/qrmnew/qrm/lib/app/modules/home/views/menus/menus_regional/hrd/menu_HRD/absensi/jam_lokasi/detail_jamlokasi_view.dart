import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class DetailJamlokasiView extends StatelessWidget {
  DetailJamlokasiView({
    super.key,
    this.name,
    this.address,
    this.time_in,
    this.time_out,
    this.radius,
    this.latitude_longtitude,
  });

  final String? name;
  final String? address;
  final String? time_in;
  final String? time_out;
  final String? radius;
  final String? latitude_longtitude;

  final OutlineInputBorder borderStyle = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(color: Colors.black, width: 2),
  );

  final TextEditingController namaController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController time_inController = TextEditingController();
  final TextEditingController time_outController = TextEditingController();
  final TextEditingController radiusController = TextEditingController();
  final TextEditingController latitude_longtitudeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    namaController.text = name ?? '';
    addressController.text = address ?? '';
    time_inController.text = time_in ?? '';
    time_outController.text = time_out ?? '';
    radiusController.text = radius ?? '';
    latitude_longtitudeController.text = latitude_longtitude ?? '';

    if (latitude_longtitude != null &&
        RegExp(r'^-?\d+(\.\d+)?\s*,\s*-?\d+(\.\d+)?$')
            .hasMatch(latitude_longtitude!)) {
      final parts = latitude_longtitude!.split(',');
      final lat = double.tryParse(parts[0].trim());
      final lng = double.tryParse(parts[1].trim());
      if (lat != null && lng != null) {}
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            const Text('Jam dan lokasi', style: TextStyle(color: Colors.white)),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: ['4CA1AF'.hex, '808080'.hex],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: LzListView(
          children: [
            TextFormField(
              readOnly: true,
              controller: namaController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Nama Alamat',
                labelStyle: const TextStyle(fontWeight: Fw.bold),
                border: borderStyle,
                focusedBorder: borderStyle.copyWith(
                  borderSide: borderStyle.borderSide.copyWith(
                    color: const Color.fromARGB(255, 0, 61, 230),
                    width: 2,
                  ),
                ),
              ),
            ),
            15.height,
            TextFormField(
              readOnly: true,
              controller: addressController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Alamat',
                labelStyle: const TextStyle(fontWeight: Fw.bold),
                border: borderStyle,
                focusedBorder: borderStyle.copyWith(
                  borderSide: borderStyle.borderSide.copyWith(
                    color: const Color.fromARGB(255, 0, 61, 230),
                    width: 2,
                  ),
                ),
              ),
            ),
            15.height,
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: time_inController,
                    decoration: InputDecoration(
                      labelText: 'Jam Masuk',
                      labelStyle: const TextStyle(fontWeight: Fw.bold),
                      border: borderStyle,
                      focusedBorder: borderStyle.copyWith(
                        borderSide: borderStyle.borderSide.copyWith(
                          color: const Color.fromARGB(255, 0, 61, 230),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    controller: time_outController,
                    decoration: InputDecoration(
                      labelText: 'Jam Pulang',
                      labelStyle: const TextStyle(fontWeight: Fw.bold),
                      border: borderStyle,
                      focusedBorder: borderStyle.copyWith(
                        borderSide: borderStyle.borderSide.copyWith(
                          color: const Color.fromARGB(255, 0, 61, 230),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            20.height,
            TextFormField(
              readOnly: true,
              controller: radiusController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'Radius',
                labelStyle: const TextStyle(fontWeight: Fw.bold),
                border: borderStyle,
                focusedBorder: borderStyle.copyWith(
                  borderSide: borderStyle.borderSide.copyWith(
                    color: const Color.fromARGB(255, 0, 61, 230),
                    width: 2,
                  ),
                ),
              ),
            ),
            20.height,
            TextFormField(
              readOnly: true,
              controller: latitude_longtitudeController,
              maxLines: 1,
              decoration: InputDecoration(
                labelText: 'latitude longtitude',
                labelStyle: const TextStyle(fontWeight: Fw.bold),
                border: borderStyle,
                focusedBorder: borderStyle.copyWith(
                  borderSide: borderStyle.borderSide.copyWith(
                    color: const Color.fromARGB(255, 0, 61, 230),
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
