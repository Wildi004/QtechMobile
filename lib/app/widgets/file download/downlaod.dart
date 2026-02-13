import 'dart:io';
import 'dart:typed_data';
import 'package:fetchly/utils/log.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Downlaod {
  /// Simpan file ke direktori Download
  static Future<String?> saveFile(
    Uint8List bytes,
    String fileName,
  ) async {
    try {
      logg("==== Mulai proses saveFile ====");
      logg("Target fileName: $fileName");
      logg("Ukuran bytes: ${bytes.length}");
      if (Platform.isAndroid) {
        logg("Request permission manageExternalStorage...");
        var status = await Permission.manageExternalStorage.request();
        logg("Status permission: $status");

        if (!status.isGranted) {
          logg("Permission ditolak, batal simpan file");
          return null;
        }
      }
      Directory? dir;
      if (Platform.isAndroid) {
        dir = Directory('/storage/emulated/0/Download/Dokumen Q-tech Mobile');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
        logg("Platform Android, pakai folder Download: ${dir.path}");
      } else {
        dir = await getApplicationDocumentsDirectory();
        logg("Platform iOS, pakai folder Documents: ${dir.path}");
      }

      if (!dir.existsSync()) {
        logg("Direktori belum ada, membuat folder: ${dir.path}");
        dir.createSync(recursive: true);
      } else {
        logg("Direktori sudah ada: ${dir.path}");
      }

      final file = File('${dir.path}/$fileName');
      logg("Membuat file di path: ${file.path}");

      await file.writeAsBytes(bytes);
      logg("File berhasil disimpan: ${file.path}");

      logg("==== Selesai saveFile ====");
      return file.path;
    } catch (e, s) {
      logg("Gagal simpan file: $e");
      logg("StackTrace: $s");
      return null;
    }
  }
}
