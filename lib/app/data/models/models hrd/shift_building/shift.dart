class Shifts {
  int? shiftId;
  String? shiftName;
  String? timeIn;
  String? timeOut;

  Shifts({this.shiftId, this.shiftName, this.timeIn, this.timeOut});

  factory Shifts.fromJson(Map<String, dynamic> json) => Shifts(
        shiftId: json['shift_id'] as int?,
        shiftName: json['shift_name'] as String?,
        timeIn: json['time_in'] as String?,
        timeOut: json['time_out'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'shift_id': shiftId,
        'shift_name': shiftName,
        'time_in': timeIn,
        'time_out': timeOut,
      };
  static List<Shifts> fromJsonList(List? data) {
    return (data ?? []).map((e) => Shifts.fromJson(e)).toList();
  }
}
