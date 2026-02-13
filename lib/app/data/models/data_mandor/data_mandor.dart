import 'detail.dart';

class DataMandor {
  int? id;
  String? resourceId;
  String? nama;
  String? alamatKtp;
  String? noHp;
  String? alamatDomisili;
  String? ktp;
  String? kode;
  int? createdAt;
  int? createdBy;
  int? status;
  int? harga;
  int? ketepatanWaktu;
  int? kualitasPekerjaan;
  int? kepatuhanSafety;
  int? komunikasi;
  int? nilaiTotal;
  String? rating;
  String? spesialis;
  int? updateBy;
  String? createdName;
  String? updateName;
  List<Detail>? detail;

  DataMandor({
    this.id,
    this.nama,
    this.alamatKtp,
    this.noHp,
    this.alamatDomisili,
    this.ktp,
    this.kode,
    this.createdAt,
    this.createdBy,
    this.status,
    this.resourceId,
    this.harga,
    this.ketepatanWaktu,
    this.kualitasPekerjaan,
    this.kepatuhanSafety,
    this.komunikasi,
    this.nilaiTotal,
    this.rating,
    this.spesialis,
    this.updateBy,
    this.createdName,
    this.updateName,
    this.detail,
  });

  factory DataMandor.fromJson(Map<String, dynamic> json) => DataMandor(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        alamatKtp: json['alamat_ktp'] as String?,
        noHp: json['no_hp'] as String?,
        alamatDomisili: json['alamat_domisili'] as String?,
        ktp: json['ktp'] as String?,
        resourceId: json['resource_id'] as String?,
        kode: json['kode'] as String?,
        createdAt: json['created_at'] as int?,
        createdBy: json['created_by'] as int?,
        status: json['status'] as int?,
        harga: json['harga'] as int?,
        ketepatanWaktu: json['ketepatan_waktu'] as int?,
        kualitasPekerjaan: json['kualitas_pekerjaan'] as int?,
        kepatuhanSafety: json['kepatuhan_safety'] as int?,
        komunikasi: json['komunikasi'] as int?,
        nilaiTotal: json['nilai_total'] as int?,
        rating: json['rating'] as String?,
        spesialis: json['spesialis'] as String?,
        updateBy: json['update_by'] as int?,
        createdName: json['created_name'] as String?,
        updateName: json['update_name'] as String?,
        detail: (json['detail'] as List<dynamic>?)
            ?.map((e) => Detail.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'alamat_ktp': alamatKtp,
        'no_hp': noHp,
        'alamat_domisili': alamatDomisili,
        'ktp': ktp,
        'kode': kode,
        'created_at': createdAt,
        'resource_id': resourceId,
        'created_by': createdBy,
        'status': status,
        'harga': harga,
        'ketepatan_waktu': ketepatanWaktu,
        'kualitas_pekerjaan': kualitasPekerjaan,
        'kepatuhan_safety': kepatuhanSafety,
        'komunikasi': komunikasi,
        'nilai_total': nilaiTotal,
        'rating': rating,
        'spesialis': spesialis,
        'update_by': updateBy,
        'created_name': createdName,
        'update_name': updateName,
        'detail': detail?.map((e) => e.toJson()).toList(),
      };

  static List<DataMandor> fromJsonList(List? data) {
    return (data ?? []).map((e) => DataMandor.fromJson(e)).toList();
  }
}
