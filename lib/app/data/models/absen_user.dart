class AbsenUser {
  int? presenceId;
  int? userId;
  String? presenceDate;
  String? timeIn;
  String? timeOut;
  String? pictureIn;
  String? pictureOut;
  int? presentId;
  String? latitudeLongtitudeIn;
  String? latitudeLongtitudeOut;
  String? information;
  String? presentName;
  bool? isExist;

  AbsenUser({
    this.presenceId,
    this.userId,
    this.presenceDate,
    this.timeIn,
    this.timeOut,
    this.pictureIn,
    this.pictureOut,
    this.presentId,
    this.latitudeLongtitudeIn,
    this.latitudeLongtitudeOut,
    this.information,
    this.presentName,
    this.isExist,
  });

  factory AbsenUser.fromJson(Map<String, dynamic> json) => AbsenUser(
        presenceId: json['presence_id'] as int?,
        userId: json['user_id'] as int?,
        presenceDate: json['presence_date'] as String?,
        timeIn: json['time_in'] as String?,
        timeOut: json['time_out'] as String?,
        pictureIn: json['picture_in'] as String?,
        pictureOut: json['picture_out'] as String?,
        presentId: json['present_id'] as int?,
        latitudeLongtitudeIn: json['latitude_longtitude_in'] as String?,
        latitudeLongtitudeOut: json['latitude_longtitude_out'] as String?,
        information: json['information'] as String?,
        presentName: json['present_name'] as String?,
        isExist: json['is_exist'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'presence_id': presenceId,
        'user_id': userId,
        'presence_date': presenceDate,
        'time_in': timeIn,
        'time_out': timeOut,
        'picture_in': pictureIn,
        'picture_out': pictureOut,
        'present_id': presentId,
        'latitude_longtitude_in': latitudeLongtitudeIn,
        'latitude_longtitude_out': latitudeLongtitudeOut,
        'information': information,
        'present_name': presentName,
        'is_exist': isExist,
      };
}
