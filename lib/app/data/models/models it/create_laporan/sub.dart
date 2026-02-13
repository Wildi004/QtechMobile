class Sub {
  int? id;
  String? sub;

  Sub({this.id, this.sub});

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
        id: json['id'] as int?,
        sub: json['sub'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'sub': sub,
      };
}
