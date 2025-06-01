class Departemen {
  int? id;
  String? departemen;
  int? companyId;
  String? company;

  Departemen({this.id, this.departemen, this.companyId, this.company});

  factory Departemen.fromJson(Map<String, dynamic> json) => Departemen(
        id: json['id'] as int?,
        departemen: json['departemen'] as String?,
        companyId: json['company_id'] as int?,
        company: json['company'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'departemen': departemen,
        'company_id': companyId,
        'company': company,
      };

  static List<Departemen> fromJsonList(List? data) {
    return (data ?? []).map((e) => Departemen.fromJson(e)).toList();
  }
}
