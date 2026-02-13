import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lazyui/lazyui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/downlaod.dart';

class DownloadFile extends StatelessWidget {
  final Uint8List fileBytes;
  final String fileType;

  const DownloadFile({
    super.key,
    required this.fileBytes,
    required this.fileType,
  });

  @override
  Widget build(BuildContext context) {
    if (fileType == 'pdf') {
      return _buildPdfViewer(context);
    } else {
      return _buildImageViewer(context);
    }
  }

  Widget _buildPdfViewer(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: 'File',
        actions: [
          IconButton(
            onPressed: () async {
              final messenger = ScaffoldMessenger.of(context);

              final timestamp = DateTime.now().millisecondsSinceEpoch;
              final fileName = fileType == 'pdf'
                  ? 'dokumen_$timestamp.pdf'
                  : 'gambar_$timestamp.png';

              final savedPath = await Downlaod.saveFile(fileBytes, fileName);

              if (savedPath != null) {
                messenger.showSnackBar(
                  SnackBar(
                      content: Text("File berhasil disimpan di: $savedPath")),
                );
              } else {
                messenger.showSnackBar(
                  const SnackBar(content: Text("Gagal menyimpan file")),
                );
              }
            },
            icon: Icon(Hi.download01),
          )
        ],
      ).appBar,
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

  Widget _buildImageViewer(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: '',
        actions: [
          IconButton(
            onPressed: () async {},
            icon: Icon(Hi.download01),
          )
        ],
      ).appBar,
      body: Center(
        child: PhotoView(
          imageProvider: MemoryImage(fileBytes),
        ),
      ),
    );
  }

  Future<String> _saveTempFile(String extension) async {
    final dir = await getTemporaryDirectory();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final path = '${dir.path}/file_$timestamp$extension';
    final file = File(path);
    await file.writeAsBytes(fileBytes);
    return path;
  }
}
