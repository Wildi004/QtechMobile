class PembelianSupplier {
  final String? namaPerusahaan;
  final int? totalPo;
  final int? totalInvoice;

  PembelianSupplier({
    this.namaPerusahaan,
    this.totalPo,
    this.totalInvoice,
  });

  factory PembelianSupplier.fromJson(Map<String, dynamic> json) {
    return PembelianSupplier(
      namaPerusahaan: json['nama_perusahaan'],

      // aman: bisa menerima int, double, atau null
      totalPo:
          (json['total_po'] is num) ? (json['total_po'] as num).toInt() : null,

      totalInvoice: (json['total_invoice'] is num)
          ? (json['total_invoice'] as num).toInt()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_perusahaan': namaPerusahaan,
      'total_po': totalPo,
      'total_invoice': totalInvoice,
    };
  }
}
