class LaporanIt {
  String? minggu;
  String? periode;
  String? encryptedMinggu;

  LaporanIt({this.minggu, this.periode, this.encryptedMinggu});

  factory LaporanIt.fromJson(Map<String, dynamic> json) => LaporanIt(
        minggu: json['minggu'] as String?,
        periode: json['periode'] as String?,
        encryptedMinggu: json['encrypted_minggu'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'minggu': minggu,
        'periode': periode,
        'encrypted_minggu': encryptedMinggu,
      };

  static List<LaporanIt> fromJsonList(List? data) {
    return (data ?? []).map((e) => LaporanIt.fromJson(e)).toList();
  }
}
