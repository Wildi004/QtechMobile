import 'building.dart';
import 'shift.dart';

class ShiftBuilding {
  int? id;
  int? shiftId;
  int? buildingId;
  Shifts? shift;
  Building? building;

  ShiftBuilding({
    this.id,
    this.shiftId,
    this.buildingId,
    this.shift,
    this.building,
  });

  factory ShiftBuilding.fromJson(Map<String, dynamic> json) => ShiftBuilding(
        id: json['id'] as int?,
        shiftId: json['shift_id'] as int?,
        buildingId: json['building_id'] as int?,
        shift: json['shift'] == null
            ? null
            : Shifts.fromJson(json['shift'] as Map<String, dynamic>),
        building: json['building'] == null
            ? null
            : Building.fromJson(json['building'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'shift_id': shiftId,
        'building_id': buildingId,
        'shift': shift?.toJson(),
        'building': building?.toJson(),
      };

  static List<ShiftBuilding> fromJsonList(List? data) {
    return (data ?? []).map((e) => ShiftBuilding.fromJson(e)).toList();
  }
}
