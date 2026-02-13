class Supplier {
  int? id;
  String? namaPerusahaan;
  String? cp1;
  String? cp2;
  String? cp3;
  String? email1;
  String? email2;
  String? email3;
  String? alamat;
  String? noTelp1;
  String? noTelp2;
  String? noTelp3;
  String? noFax;
  String? npwp;
  String? rek1;
  String? bank1;
  String? rek2;
  String? bank2;
  String? rek3;
  String? bank3;
  int? createdAt;

  Supplier({
    this.id,
    this.namaPerusahaan,
    this.cp1,
    this.cp2,
    this.cp3,
    this.email1,
    this.email2,
    this.email3,
    this.alamat,
    this.noTelp1,
    this.noTelp2,
    this.noTelp3,
    this.noFax,
    this.npwp,
    this.rek1,
    this.bank1,
    this.rek2,
    this.bank2,
    this.rek3,
    this.bank3,
    this.createdAt,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) => Supplier(
        id: json['id'] as int?,
        namaPerusahaan: json['nama_perusahaan'] as String?,
        cp1: json['cp1'] as String?,
        cp2: json['cp2'] as String?,
        cp3: json['cp3'] as String?,
        email1: json['email1'] as String?,
        email2: json['email2'] as String?,
        email3: json['email3'] as String?,
        alamat: json['alamat'] as String?,
        noTelp1: json['no_telp1'] as String?,
        noTelp2: json['no_telp2'] as String?,
        noTelp3: json['no_telp3'] as String?,
        noFax: json['no_fax'] as String?,
        npwp: json['npwp'] as String?,
        rek1: json['rek1'] as String?,
        bank1: json['bank1'] as String?,
        rek2: json['rek2'] as String?,
        bank2: json['bank2'] as String?,
        rek3: json['rek3'] as String?,
        bank3: json['bank3'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama_perusahaan': namaPerusahaan,
        'cp1': cp1,
        'cp2': cp2,
        'cp3': cp3,
        'email1': email1,
        'email2': email2,
        'email3': email3,
        'alamat': alamat,
        'no_telp1': noTelp1,
        'no_telp2': noTelp2,
        'no_telp3': noTelp3,
        'no_fax': noFax,
        'npwp': npwp,
        'rek1': rek1,
        'bank1': bank1,
        'rek2': rek2,
        'bank2': bank2,
        'rek3': rek3,
        'bank3': bank3,
        'created_at': createdAt,
      };

  static List<Supplier> fromJsonList(List? data) {
    return (data ?? []).map((e) => Supplier.fromJson(e)).toList();
  }
}
