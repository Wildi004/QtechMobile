// ignore_for_file: constant_identifier_names

part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const APP = _Paths.APP;

  static const HOME = _Paths.HOME;
  static const ABSENCE = _Paths.ABSENCE;
  static const PRODUCT = _Paths.PRODUCT;
  static const SETTINGS = _Paths.SETTINGS;
  static const REG_PUSAT = _Paths.REG_PUSAT;
  static const LOGIN = _Paths.LOGIN;
  static const SPLASH_SCREEN = _Paths.SPLASH_SCREEN;
  static const KASBON = _Paths.KASBON;
  static const USER = _Paths.USER;
  static const KARYAWAN = _Paths.KARYAWAN;
  static const MENU_EDIT = _Paths.MENU_EDIT;
  static const BONUS_KARYAWAN = _Paths.BONUS_KARYAWAN;
  static const CUTI = _Paths.CUTI;
  static const BUKU_BANK = _Paths.BUKU_BANK;
  static const PASSWORD = _Paths.PASSWORD;
  static const DATA_DIRI = _Paths.DATA_DIRI;
  static const LOGIN_PIN = _Paths.LOGIN_PIN;
  static const KEAMANAN = _Paths.KEAMANAN;
  static const CAPAIAN_KINERJA = _Paths.CAPAIAN_KINERJA;
  static const MONITORING_PROYEK = _Paths.MONITORING_PROYEK;
  static const HARGA_MODAL_LOGISTIK = _Paths.HARGA_MODAL_LOGISTIK;
  static const NOTULEN = _Paths.NOTULEN;
  static const BROSUR_LOGISTIK = _Paths.BROSUR_LOGISTIK;
  static const DAFTAR_TKDN = _Paths.DAFTAR_TKDN;
  static const SURAT_DIREKSI = _Paths.SURAT_DIREKSI;
  static const JOB_DESK = _Paths.JOB_DESK;
  static const CAPAIAN = _Paths.CAPAIAN;
  static const SURAT_INTERNAL = _Paths.SURAT_INTERNAL;
  static const DATA_MANDOR = _Paths.DATA_MANDOR;
  static const ROLE_AKSES = _Paths.ROLE_AKSES;
  static const PENGATURAN = _Paths.PENGATURAN;
  static const FORM_PENGAJUAN = _Paths.FORM_PENGAJUAN;
  static const SELECT_LOCATION = _Paths.SELECT_LOCATION;
  static const FORM_BUILDING_HRD = _Paths.FORM_BUILDING_HRD;
  static const add_building_hrd = _Paths.add_building_hrd;
  static const ANGGARAN_DEPARTEMEN = _Paths.ANGGARAN_DEPARTEMEN;
  static const COMPANY_PROFILE = _Paths.COMPANY_PROFILE;
  static const PANDUAN_INSTALASI = _Paths.PANDUAN_INSTALASI;
  static const PENGUMUMAN = _Paths.PENGUMUMAN;
  static const STANDAR_TEKNIK = _Paths.STANDAR_TEKNIK;
  static const ROLE_AKSES_1 = _Paths.ROLE_AKSES_1;
}

abstract class _Paths {
  _Paths._();
  static const APP = '/';

  static const HOME = '/home';
  static const ABSENCE = '/absence';
  static const PRODUCT = '/product';
  static const SETTINGS = '/settings';
  static const REG_PUSAT = '/reg-pusat';
  static const LOGIN = '/login';
  static const SPLASH_SCREEN = '/splash-screen';
  static const KASBON = '/kasbon';
  static const USER = '/user';
  static const KARYAWAN = '/karyawan';
  static const MENU_EDIT = '/menu-edit';
  static const BONUS_KARYAWAN = '/bonus-karyawan';
  static const CUTI = '/cuti';
  static const BUKU_BANK = '/buku-bank';
  static const PASSWORD = '/password';
  static const DATA_DIRI = '/data-diri';
  static const LOGIN_PIN = '/login-pin';
  static const KEAMANAN = '/keamanan';
  static const CAPAIAN_KINERJA = '/capaian-kinerja';
  static const SELECT_LOCATION = '/select-location';
  static const FORM_BUILDING_HRD = '/form-building-hrd';

  static const FORM_PENGAJUAN = '/form-pengajuan';

  static const MONITORING_PROYEK = '/monitoring-proyek';
  static const HARGA_MODAL_LOGISTIK = '/harga-modal-logistik';
  static const NOTULEN = '/notulen';
  static const BROSUR_LOGISTIK = '/brosur-logistik';
  static const DAFTAR_TKDN = '/daftar-tkdn';
  static const SURAT_DIREKSI = '/surat-direksi';
  static const JOB_DESK = '/job-desk';
  static const CAPAIAN = '/capaian';
  static const SURAT_INTERNAL = '/surat-internal';
  static const DATA_MANDOR = '/data-mandor';
  static const ROLE_AKSES = '/role-akses';
  static const PENGATURAN = '/pengaturan';
  static const add_building_hrd = '/AddBuildingHrdView';
  static const ANGGARAN_DEPARTEMEN = '/anggaran-departemen';
  static const COMPANY_PROFILE = '/company-profile';
  static const PANDUAN_INSTALASI = '/panduan-instalasi';
  static const PENGUMUMAN = '/pengumuman';
  static const STANDAR_TEKNIK = '/standar-teknik';
  static const ROLE_AKSES_1 = '/role-akses-1';
}
