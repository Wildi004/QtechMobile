class SuratKeluarDetail {
  int? id;
  String? noHide;
  String? userPenerima;
  String? departemen;

  SuratKeluarDetail({
    this.id,
    this.noHide,
    this.userPenerima,
    this.departemen,
  });

  factory SuratKeluarDetail.fromJson(Map<String, dynamic> json) {
    return SuratKeluarDetail(
      id: json['id'] as int?,
      noHide: json['no_hide'] as String?,
      userPenerima: json['user_penerima'] as String?,
      departemen: json['departemen'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'no_hide': noHide,
        'user_penerima': userPenerima,
        'departemen': departemen,
      };
}
