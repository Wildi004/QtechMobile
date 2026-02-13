import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:lazyui/lazyui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'dart:io';
import 'package:qrm_dev/app/widgets/custom_appbar_widget.dart';
import 'package:qrm_dev/app/widgets/file%20download/downlaod.dart';

class DownloadSurat extends StatelessWidget {
  final Uint8List fileBytes;
  final String fileType;

  const DownloadSurat({
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
              final timestamp = DateTime.now().millisecondsSinceEpoch;
              final fileName = fileType == 'pdf'
                  ? 'dokumen_$timestamp.pdf'
                  : 'gambar_$timestamp.png';

              final savedPath = await Downlaod.saveFile(fileBytes, fileName);

              if (!context.mounted) return; // ⬅️ tambahkan ini

              if (savedPath != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("File berhasil disimpan di: $savedPath")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
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
            logg(
                '[DownloadSurat] PDF berhasil dibuat di temp: ${snapshot.data}');
            return PDFView(filePath: snapshot.data!);
          }
          if (snapshot.hasError) {
            logg(
                '[DownloadSurat] ERROR saat membuat file temp: ${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
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
            onPressed: () async {
              final timestamp = DateTime.now().millisecondsSinceEpoch;
              final fileName = fileType == 'pdf'
                  ? 'dokumen_$timestamp.pdf'
                  : 'gambar_$timestamp.png';

              final savedPath = await Downlaod.saveFile(fileBytes, fileName);

              // ⬅️ Tambahkan ini untuk memastikan widget masih aktif
              if (!context.mounted) return;

              if (savedPath != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text("File berhasil disimpan di: $savedPath")),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Gagal menyimpan file")),
                );
              }
            },
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
    try {
      final dir = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final path = '${dir.path}/file_$timestamp$extension';
      final file = File(path);
      await file.writeAsBytes(fileBytes);
      logg('[DownloadSurat] Temp file berhasil dibuat: $path');
      return path;
    } catch (e) {
      logg('[DownloadSurat] ERROR saat membuat temp file: $e');
      rethrow;
    }
  }
}
