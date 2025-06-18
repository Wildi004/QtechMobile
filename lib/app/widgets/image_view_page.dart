import 'dart:io';

import 'package:flutter/material.dart';

class ImageViewPage extends StatelessWidget {
  final String filePath;

  const ImageViewPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lihat Gambar')),
      body: Center(
        child: Image.file(File(filePath)),
      ),
    );
  }
}
