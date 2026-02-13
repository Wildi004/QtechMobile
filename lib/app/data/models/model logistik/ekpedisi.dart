class Ekpedisi {
  int? id;
  String? nama;
  String? alamat;
  String? jenis;
  String? noHp;
  String? cp;
  String? hpCp;
  int? status;
  String? keterangan;
  int? createdAt;
  String? createdByName;

  Ekpedisi({
    this.id,
    this.nama,
    this.alamat,
    this.jenis,
    this.noHp,
    this.cp,
    this.hpCp,
    this.status,
    this.keterangan,
    this.createdAt,
    this.createdByName,
  });

  factory Ekpedisi.fromJson(Map<String, dynamic> json) => Ekpedisi(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        alamat: json['alamat'] as String?,
        jenis: json['jenis'] as String?,
        noHp: json['no_hp'] as String?,
        cp: json['cp'] as String?,
        hpCp: json['hp_cp'] as String?,
        status: json['status'] as int?,
        keterangan: json['keterangan'] as String?,
        createdAt: json['created_at'] as int?,
        createdByName: json['created_by_name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'alamat': alamat,
        'jenis': jenis,
        'no_hp': noHp,
        'cp': cp,
        'hp_cp': hpCp,
        'status': status,
        'keterangan': keterangan,
        'created_at': createdAt,
        'created_by_name': createdByName,
      };

  static List<Ekpedisi> fromJsonList(List? data) {
    return (data ?? []).map((e) => Ekpedisi.fromJson(e)).toList();
  }
}
