class SupplierInvoice {
  String? namaPerusahaan;
  int? nilaiInvoice;
  int? ppn;
  int? grandtotal;

  SupplierInvoice({
    this.namaPerusahaan,
    this.nilaiInvoice,
    this.ppn,
    this.grandtotal,
  });

  factory SupplierInvoice.fromJson(Map<String, dynamic> json) {
    return SupplierInvoice(
      namaPerusahaan: json['nama_perusahaan'],

      // aman: bisa menangani int/double/null
      nilaiInvoice: (json['nilai_invoice'] is num)
          ? (json['nilai_invoice'] as num).toInt()
          : null,

      ppn: (json['ppn'] is num) ? (json['ppn'] as num).toInt() : null,

      grandtotal: (json['grandtotal'] is num)
          ? (json['grandtotal'] as num).toInt()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nama_perusahaan': namaPerusahaan,
      'nilai_invoice': nilaiInvoice,
      'ppn': ppn,
      'grandtotal': grandtotal,
    };
  }
}
