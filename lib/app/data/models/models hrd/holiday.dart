class Holiday {
  int? holidayId;
  String? holidayDate;
  String? description;

  Holiday({this.holidayId, this.holidayDate, this.description});

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
        holidayId: json['holiday_id'] as int?,
        holidayDate: json['holiday_date'] as String?,
        description: json['description'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'holiday_id': holidayId,
        'holiday_date': holidayDate,
        'description': description,
      };

  static List<Holiday> fromJsonList(List? data) {
    return (data ?? []).map((e) => Holiday.fromJson(e)).toList();
  }
}
