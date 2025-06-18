import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerView extends StatelessWidget {
  final Uint8List bytes;

  const PdfViewerView({super.key, required this.bytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lihat File')),
      body: SfPdfViewer.memory(bytes),
    );
  }
}
