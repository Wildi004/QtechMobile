class Shift {
  int? shiftId;
  String? shiftName;
  String? timeIn;
  String? timeOut;

  Shift({this.shiftId, this.shiftName, this.timeIn, this.timeOut});

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
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

  static List<Shift> fromJsonList(List? data) {
    return (data ?? []).map((e) => Shift.fromJson(e)).toList();
  }
}
