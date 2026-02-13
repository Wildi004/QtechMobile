class MasaTanggang {
  int? id;
  String? namaHosting;
  String? penyedia;
  String? tglExpired;
  String? createdByName;

  MasaTanggang({
    this.id,
    this.namaHosting,
    this.penyedia,
    this.tglExpired,
    this.createdByName,
  });

  factory MasaTanggang.fromJson(Map<String, dynamic> json) => MasaTanggang(
        id: json['id'] as int?,
        namaHosting: json['nama_hosting'] as String?,
        penyedia: json['penyedia'] as String?,
        tglExpired: json['tgl_expired'] as String?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_hosting': namaHosting,
        'penyedia': penyedia,
        'tgl_expired': tglExpired,
        'created_by_name': createdByName,
      };

  static List<MasaTanggang> fromJsonList(List? data) {
    return (data ?? []).map((e) => MasaTanggang.fromJson(e)).toList();
  }
}
