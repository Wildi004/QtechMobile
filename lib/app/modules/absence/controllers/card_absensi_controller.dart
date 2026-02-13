import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide MultipartFile;
import 'package:intl/intl.dart';
import 'package:lazyui/lazyui.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qrm_dev/app/core/utils/extensions.dart';
import 'package:qrm_dev/app/data/apis/api.dart';
import 'package:qrm_dev/app/data/models/absen_user.dart';
import 'package:qrm_dev/app/data/models/models%20hrd/shift_building/building.dart';
import 'package:qrm_dev/app/data/models/user.dart';

class CardAbsensiController extends GetxController with Apis {
  RxDouble height = 200.0.obs;
  RxBool isLoading = true.obs;

  Rxn<AbsenUser> absen = Rxn<AbsenUser>();
  String get jamMasuks => absen.value?.timeIn ?? '';

  void adjustHeader(double value) {
    height.value = value;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  Future getUserAbsen() async {
    try {
      final res = await api.absensi.getData();
      absen.value = AbsenUser.fromJson(res.data);
      isLoading.value = false;
    } catch (e, s) {
      Errors.check(e, s);
    }
  }

  var currentDate = ''.obs;

  var currentTime = ''.obs;
  Timer? _timer;

  Future onPageInit() async {
    try {} catch (e, s) {
      Errors.check(e, s);
    }
  }

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onPageInit();
      getUserAbsen();
    });

    currentTime.value = '${DateFormat('HH:mm:ss').format(DateTime.now())} WITA';
    currentDate.value =
        DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(DateTime.now());

    currentTime.value = '${DateFormat('HH:mm:ss').format(DateTime.now())} WITA';
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      currentTime.value =
          '${DateFormat('HH:mm:ss').format(DateTime.now())} WITA';
    });
  }

  var showButton = true.obs;

  void hideButtonTemporarily() {
    showButton.value = false;
    Future.delayed(const Duration(seconds: 60), () {
      showButton.value = true;

      absen.value = AbsenUser(
        timeIn: '00:00:00',
        timeOut: '00:00:00',
      );
    });
  }

  // absensi

  Position? userLocation;
  RxBool isLoadingLocation = true.obs;
  bool isValidLocation = false;
  String distanceMessage = '';

  Future<Building> getTargetLocations() async {
    try {
      final res = await api.building.getData();
      List<Building> buildings = Building.fromJsonList(res.data);

      final resUser = await api.user.current({});
      final user = User.fromJson(resUser.data);

      logg('-- kantor user: ${user.building}');

      // cari kantor user
      final building = buildings.firstWhere(
        (e) => e.name == user.building,
        orElse: () => Building(),
      );

      logg('-- radius kantor user: ${building.radius}');
      return building;
    } catch (e, s) {
      Errors.check(e, s);
      return Building();
    }
  }

  Future<bool> calculateDistance(double userLat, double userLon,
      double targetLat, double targetLon, double radiusMeter) async {
    try {
      const double earthRadius = 6371; // km

      double degToRad(double deg) => deg * pi / 180.0;

      double dLat = degToRad(targetLat - userLat);
      double dLon = degToRad(targetLon - userLon);

      double lat1 = degToRad(userLat);
      double lat2 = degToRad(targetLat);

      double a =
          pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);

      double c = 2 * atan2(sqrt(a), sqrt(1 - a));
      double distance = earthRadius * c; // hasil dalam km

      // ubah radius meter → km
      double radiusKm = radiusMeter / 1000;

      logg("Jarak user dengan kantor: $distance km, radius: $radiusKm km");

      if (distance > radiusKm) {
        distanceMessage =
            'Jarak Anda dengan kantor terlalu jauh, ${distance.toStringAsFixed(11)} km';
      } else {
        distanceMessage = 'Anda dalam radius Kantor';
      }
      // 'Jarak Anda dengan kantor adalah ${distance.toStringAsFixed(2)} km'
      return distance <= radiusKm;
    } catch (e, s) {
      Errors.check(e, s);
      return false;
    }
  }

  void checkUserLocation({bool autoAbsen = false, File? photo}) async {
    isLoadingLocation.value = true;

    void error(String message) {
      isLoadingLocation.value = false;
      Toast.error(message);
    }

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return error('GPS Anda tidak aktif.');

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return error('Akses lokasi ditolak.');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return error(
            'Akses lokasi tidak diizinkan secara permanen, buka pengaturan untuk mengaktifkannya.');
      }

      // user
      final location = await Geolocator.getCurrentPosition();
      userLocation = location;

      final Building target = await getTargetLocations();

      if (target.name == null || target.latitudeLongtitude == null) {
        return error('Data kantor tidak ditemukan.');
      }

      final coords = target.latitudeLongtitude!
          .split(',')
          .map((e) => double.tryParse(e.trim()))
          .where((e) => e != null)
          .toList();

      if (coords.length < 2) {
        return error('Data koordinat kantor tidak valid.');
      }

      double userLat = location.latitude;
      double userLon = location.longitude;
      double targetLat = (coords[0] ?? 0).toDouble();
      double targetLon = (coords[1] ?? 0).toDouble();
      double radius = (target.radius ?? 100).toDouble();

      final isValid = await calculateDistance(
        userLat,
        userLon,
        targetLat,
        targetLon,
        radius,
      );

      isValidLocation = isValid;

      isLoadingLocation.value = false;

      if (isValid) {
        Toast.success('Anda berada di dalam radius kantor.');
        if (autoAbsen && photo != null) {
          await doAttendance(photo);
        }
      } else {
        Toast.warning('Anda berada di luar radius kantor.');
      }
    } catch (e, s) {
      Errors.check(e, s);
      error('Terjadi kesalahan saat memeriksa lokasi.');
    }
  }

  Future doAttendance(File file) async {
    try {
      logg('📸 Original size: ${await file.length()} bytes');

      final compressed = await compressImage(file);

      if (compressed == null) {
        return Toast.error('Gagal mengompres foto.');
      }
      if (await compressed.length() > 1000000) {
        Toast.warning('Ukuran foto masih terlalu besar.');
        return;
      }

      logg('📸 Compressed size: ${await compressed.length()} bytes');

      final photo = await MultipartFile.fromFile(
        compressed.path,
        filename: 'webcam_${DateTime.now().millisecondsSinceEpoch}.jpg',
      );

      logg('✅ [doAttendance] MultipartFile dibuat: ${photo.filename}');

      final Building target = await getTargetLocations();
      logg('🏢 [doAttendance] Data kantor: ${target.name}');
      logg('📍 [doAttendance] Radius kantor: ${target.radius}');
      logg('📍 [doAttendance] Koordinat kantor: ${target.latitudeLongtitude}');
      logg(
          '📍 [doAttendance] Lokasi user: ${userLocation?.latitude}, ${userLocation?.longitude}');

      if (target.name == null || target.radius == null) {
        logg('❌ [doAttendance] Data kantor tidak valid.');
        return Toast.error('Data kantor tidak valid.');
      }

      logg('🚀 [doAttendance] Mengirim data absensi ke API...');
      final res = await api.absensi
          .sendAbsen({
            'latitude': '${userLocation?.latitude},${userLocation?.longitude}',
            'radius': target.radius,
            'webcam': photo,
          })
          .ui
          .loading();

      logg('📩 [doAttendance] Response dari server: ${res.message ?? ()}');

      if (!res.status) {
        logg('❌ [doAttendance] Gagal absen: ${res.message}');
        return Toast.error(res.message);
      }

      logg('✅ [doAttendance] Berhasil absen: ${res.message}');
      Toast.success(res.message);
      await getUserAbsen();
      Get.back();

      logg('🏁 [doAttendance] Proses absensi selesai.');
    } catch (e, s) {
      logg('🔥 [doAttendance] Error: $e');
      logg('📄 Stacktrace: $s');
      Errors.check(e, s);
    }
  }

  Future<XFile?> compressImage(File file) async {
    final dir = await getTemporaryDirectory();
    final targetPath =
        '${dir.path}/compressed_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 30,
      minWidth: 640,
      minHeight: 640,
      format: CompressFormat.jpeg,
    );

    return result;
  }
}
