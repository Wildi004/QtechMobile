import 'package:fetchly/utils/log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewPage extends StatelessWidget {
  final String filePath;

  const PdfViewPage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lihat PDF')),
      body: PDFView(
        filePath: filePath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: true,
        pageFling: true,
        onRender: (_pages) {
          logg('PDF dirender dengan $_pages halaman');
        },
        onError: (error) {
          logg('Error PDF: $error');
        },
        onPageError: (page, error) {
          logg('Error halaman $page: $error');
        },
      ),
    );
  }
}
