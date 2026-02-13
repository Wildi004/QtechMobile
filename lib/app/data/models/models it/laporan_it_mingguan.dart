class LaporanItMingguan {
  String? tglRencana;
  String? minggu;
  String? userName;
  String? encryptedTglRencana;
  String? encryptedPic;

  LaporanItMingguan({
    this.tglRencana,
    this.minggu,
    this.userName,
    this.encryptedTglRencana,
    this.encryptedPic,
  });

  factory LaporanItMingguan.fromJson(Map<String, dynamic> json) {
    return LaporanItMingguan(
      tglRencana: json['tgl_rencana'] as String?,
      minggu: json['minggu'] as String?,
      userName: json['user_name'] as String?,
      encryptedTglRencana: json['encrypted_tgl_rencana'] as String?,
      encryptedPic: json['encrypted_pic'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'tgl_rencana': tglRencana,
        'minggu': minggu,
        'user_name': userName,
        'encrypted_tgl_rencana': encryptedTglRencana,
        'encrypted_pic': encryptedPic,
      };

  static List<LaporanItMingguan> fromJsonList(List? data) {
    return (data ?? []).map((e) => LaporanItMingguan.fromJson(e)).toList();
  }
}
