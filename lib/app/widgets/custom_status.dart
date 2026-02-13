class ErrorHelper {
  static String getErrorMessage(int statusCode) {
    switch (statusCode) {
      case 400:
        return 'Permintaan tidak valid (400).';
      case 401:
        return 'Tidak diizinkan, silakan login kembali (401).';
      case 403:
        return 'Akses ditolak (403).';
      case 404:
        return 'Data tidak ditemukan (404).';
      case 500:
        return 'Terjadi kesalahan server (500).';
      default:
        return 'Terjadi kesalahan tidak diketahui ($statusCode).';
    }
  }
}
