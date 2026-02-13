class DetailOrang {
  int? id;
  int? pengajuanId;
  String? noPengajuan;
  String? kodePengajuan;
  String? nama;
  String? ktp;
  String? status;
  String? ttl;
  String? agama;
  String? alamat;
  String? noTelp;
  String? namaBpk;
  String? namaIbu;
  String? alamatBpk;
  String? namaPasangan;
  String? alamatPasangan;
  String? noTelpPasangan;
  String? alamatSd;
  String? tahunSd;
  String? alamatSmp;
  String? tahunSmp;
  String? alamatSma;
  String? tahunSma;
  String? alamatS1;
  String? tahunS1;
  String? alamatS2;
  String? tahunS2;
  String? namaSd;
  String? namaSmp;
  String? namaSma;
  String? namaUniv1;
  String? namaUniv2;
  String? fotoDiri;
  String? fotoKtp;
  String? fotoKk;
  String? fotoSkck;
  int? statusGm;
  String? komentar;
  int? createdAt;

  DetailOrang({
    this.id,
    this.pengajuanId,
    this.noPengajuan,
    this.kodePengajuan,
    this.nama,
    this.ktp,
    this.status,
    this.ttl,
    this.agama,
    this.alamat,
    this.noTelp,
    this.namaBpk,
    this.namaIbu,
    this.alamatBpk,
    this.namaPasangan,
    this.alamatPasangan,
    this.noTelpPasangan,
    this.alamatSd,
    this.tahunSd,
    this.alamatSmp,
    this.tahunSmp,
    this.alamatSma,
    this.tahunSma,
    this.alamatS1,
    this.tahunS1,
    this.alamatS2,
    this.tahunS2,
    this.namaSd,
    this.namaSmp,
    this.namaSma,
    this.namaUniv1,
    this.namaUniv2,
    this.fotoDiri,
    this.fotoKtp,
    this.fotoKk,
    this.fotoSkck,
    this.statusGm,
    this.komentar,
    this.createdAt,
  });

  factory DetailOrang.fromJson(Map<String, dynamic> json) => DetailOrang(
        id: json['id'] as int?,
        pengajuanId: json['pengajuan_id'] as int?,
        noPengajuan: json['no_pengajuan'] as String?,
        kodePengajuan: json['kode_pengajuan'] as String?,
        nama: json['nama'] as String?,
        ktp: json['ktp'] as String?,
        status: json['status'] as String?,
        ttl: json['ttl'] as String?,
        agama: json['agama'] as String?,
        alamat: json['alamat'] as String?,
        noTelp: json['no_telp'] as String?,
        namaBpk: json['nama_bpk'] as String?,
        namaIbu: json['nama_ibu'] as String?,
        alamatBpk: json['alamat_bpk'] as String?,
        namaPasangan: json['nama_pasangan'] as String?,
        alamatPasangan: json['alamat_pasangan'] as String?,
        noTelpPasangan: json['no_telp_pasangan'] as String?,
        alamatSd: json['alamat_sd'] as String?,
        tahunSd: json['tahun_sd'] as String?,
        alamatSmp: json['alamat_smp'] as String?,
        tahunSmp: json['tahun_smp'] as String?,
        alamatSma: json['alamat_sma'] as String?,
        tahunSma: json['tahun_sma'] as String?,
        alamatS1: json['alamat_s1'] as String?,
        tahunS1: json['tahun_s1'] as String?,
        alamatS2: json['alamat_s2'] as String?,
        tahunS2: json['tahun_s2'] as String?,
        namaSd: json['nama_sd'] as String?,
        namaSmp: json['nama_smp'] as String?,
        namaSma: json['nama_sma'] as String?,
        namaUniv1: json['nama_univ1'] as String?,
        namaUniv2: json['nama_univ2'] as String?,
        fotoDiri: json['foto_diri'] as String?,
        fotoKtp: json['foto_ktp'] as String?,
        fotoKk: json['foto_kk'] as String?,
        fotoSkck: json['foto_skck'] as String?,
        statusGm: json['status_gm'] as int?,
        komentar: json['komentar'] as String?,
        createdAt: json['created_at'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'pengajuan_id': pengajuanId,
        'no_pengajuan': noPengajuan,
        'kode_pengajuan': kodePengajuan,
        'nama': nama,
        'ktp': ktp,
        'status': status,
        'ttl': ttl,
        'agama': agama,
        'alamat': alamat,
        'no_telp': noTelp,
        'nama_bpk': namaBpk,
        'nama_ibu': namaIbu,
        'alamat_bpk': alamatBpk,
        'nama_pasangan': namaPasangan,
        'alamat_pasangan': alamatPasangan,
        'no_telp_pasangan': noTelpPasangan,
        'alamat_sd': alamatSd,
        'tahun_sd': tahunSd,
        'alamat_smp': alamatSmp,
        'tahun_smp': tahunSmp,
        'alamat_sma': alamatSma,
        'tahun_sma': tahunSma,
        'alamat_s1': alamatS1,
        'tahun_s1': tahunS1,
        'alamat_s2': alamatS2,
        'tahun_s2': tahunS2,
        'nama_sd': namaSd,
        'nama_smp': namaSmp,
        'nama_sma': namaSma,
        'nama_univ1': namaUniv1,
        'nama_univ2': namaUniv2,
        'foto_diri': fotoDiri,
        'foto_ktp': fotoKtp,
        'foto_kk': fotoKk,
        'foto_skck': fotoSkck,
        'status_gm': statusGm,
        'komentar': komentar,
        'created_at': createdAt,
      };
}
