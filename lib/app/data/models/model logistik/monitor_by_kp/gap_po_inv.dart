class GapInvoicePo {
  String? namaPerusahaan;
  int? totalPo;
  int? totalInvoice;
  int? gap;
  String? warna;

  GapInvoicePo({
    this.namaPerusahaan,
    this.totalPo,
    this.totalInvoice,
    this.gap,
    this.warna,
  });

  factory GapInvoicePo.fromJson(Map<String, dynamic> json) => GapInvoicePo(
        namaPerusahaan: json['nama_perusahaan'],
        totalPo: toInt(json['total_po']),
        totalInvoice: toInt(json['total_invoice']),
        gap: toInt(json['gap']),
        warna: json['warna'],
      );

  Map<String, dynamic> toJson() => {
        "nama_perusahaan": namaPerusahaan,
        "total_po": totalPo,
        "total_invoice": totalInvoice,
        "gap": gap,
        "warna": warna,
      };
}

int? toInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is double) return v.toInt();
  if (v is String) return int.tryParse(v);
  return null;
}
