import 'detail_aset.dart';

class ServiceAset {
  int? id;
  int? asetId;
  String? jenisAset;
  String? kodeAset;
  String? tglService;
  String? tempatService;
  int? biaya;
  String? keterangan;
  String? nota;
  int? createdAt;
  String? createdByName;
  String? diserviceOlehName;
  int? diserviceOleh;
  DetailAset? detailAset;

  ServiceAset({
    this.id,
    this.asetId,
    this.jenisAset,
    this.kodeAset,
    this.tglService,
    this.tempatService,
    this.biaya,
    this.diserviceOleh,
    this.keterangan,
    this.nota,
    this.createdAt,
    this.createdByName,
    this.diserviceOlehName,
    this.detailAset,
  });

  factory ServiceAset.fromJson(Map<String, dynamic> json) => ServiceAset(
        id: json['id'] as int?,
        asetId: json['aset_id'] as int?,
        diserviceOleh: json['diservice_oleh'] as int?,
        jenisAset: json['jenis_aset'] as String?,
        kodeAset: json['kode_aset'] as String?,
        tglService: json['tgl_service'] as String?,
        tempatService: json['tempat_service'] as String?,
        biaya: json['biaya'] as int?,
        keterangan: json['keterangan'] as String?,
        nota: json['nota'] as String?,
        createdAt: json['created_at'] as int?,
        createdByName: json['created_by_name'] as String?,
        diserviceOlehName: json['diservice_oleh_name'] as String?,
        detailAset: json['detail_aset'] == null
            ? null
            : DetailAset.fromJson(json['detail_aset'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'aset_id': asetId,
        'jenis_aset': jenisAset,
        'kode_aset': kodeAset,
        'tgl_service': tglService,
        'tempat_service': tempatService,
        'biaya': biaya,
        'keterangan': keterangan,
        'nota': nota,
        'created_at': createdAt,
        'created_by_name': createdByName,
        'diservice_oleh_name': diserviceOlehName,
        'detail_aset': detailAset?.toJson(),
      };

  static List<ServiceAset> fromJsonList(List? data) {
    return (data ?? []).map((e) => ServiceAset.fromJson(e)).toList();
  }
}
