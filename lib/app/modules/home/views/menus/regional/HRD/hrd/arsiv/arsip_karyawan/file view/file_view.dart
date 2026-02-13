import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';

import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';

class FileViewerPage extends StatelessWidget {
  final Uint8List fileBytes;
  final String fileType;

  const FileViewerPage({
    super.key,
    required this.fileBytes,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    if (fileType == 'pdf') {
      return _buildPdfViewer();
    } else {
      return _buildImageViewer();
    }
  }

  Widget _buildPdfViewer() {
    return Scaffold(
      appBar: CustomAppbar(title: 'File').appBar,
      body: FutureBuilder<String>(
        future: _saveTempFile('.pdf'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PDFView(filePath: snapshot.data!);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _buildImageViewer() {
    return Scaffold(
      appBar: CustomAppbar(title: 'Arsip').appBar,
      body: Center(
        child: PhotoView(
          imageProvider: MemoryImage(fileBytes),
        ),
      ),
    );
  }

  Future<String> _saveTempFile(String ext) async {
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/temp_file$ext';
    final file = File(path);
    await file.writeAsBytes(fileBytes);
    return path;
  }
}
