import 'package:get/get.dart';

import '../modules/absence/bindings/absence_binding.dart';
import '../modules/absence/views/absence_view.dart';
import '../modules/anggaran_departemen/bindings/anggaran_departemen_binding.dart';
import '../modules/anggaran_departemen/views/anggaran_departemen_view.dart';
import '../modules/brosur_logistik/bindings/brosur_logistik_binding.dart';
import '../modules/brosur_logistik/views/brosur_logistik_view.dart';
import '../modules/company_profile/bindings/company_profile_binding.dart';
import '../modules/company_profile/views/company_profile_view.dart';
import '../modules/daftar_tkdn/bindings/daftar_tkdn_binding.dart';
import '../modules/daftar_tkdn/views/daftar_tkdn_view.dart';
import '../modules/data_mandor/bindings/data_mandor_binding.dart';
import '../modules/data_mandor/views/data_mandor_view.dart';
import '../modules/harga_modal_logistik/bindings/harga_modal_logistik_binding.dart';
import '../modules/harga_modal_logistik/views/harga_modal_logistik_view.dart';
import '../modules/home/bindings/building_binding.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/bindings/validasi_binding.dart';
import '../modules/home/controllers/HRD/hrd_absen_controller/building/map/map_building_view.dart';
import '../modules/home/controllers/HRD/hrd_pengajuan_controller/form_pengajuan_controller.dart';
import '../modules/home/views/home_view.dart';
import '../modules/home/views/menu_edit/bindings/menu_edit_binding.dart';
import '../modules/home/views/menu_edit/views/menu_edit_view.dart';
import '../modules/home/views/menus/regional/BSD/dir%20bsd/validasi%20dir%20bsd/validasi%20pengajuan%20departemen/val_pengajuan_dep_view.dart';
import '../modules/home/views/menus/regional/HRD/hrd/absensi/building/add_building_hrd_view.dart';
import '../modules/home/views/menus/regional/HRD/hrd/absensi/building/form_hrd_view.dart';
import '../modules/home/views/menus/regional/HRD/hrd/pengajuan_hrd/form_pengajuan_hrd_view.dart';
import '../modules/home/views/widget home view/app/bindings/app_binding.dart';
import '../modules/home/views/widget home view/app/views/app_view.dart';
import '../modules/job_desk/bindings/job_desk_binding.dart';
import '../modules/job_desk/views/job_desk_view.dart';
import '../modules/kasbon/bindings/kasbon_binding.dart';
import '../modules/kasbon/views/kasbon_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/login_pin/bindings/login_pin_binding.dart';
import '../modules/login_pin/views/login_pin_view.dart';
import '../modules/monitoring_proyek/bindings/monitoring_proyek_binding.dart';
import '../modules/monitoring_proyek/views/monitoring_proyek_view.dart';
import '../modules/notulen/bindings/notulen_binding.dart';
import '../modules/notulen/views/notulen_view.dart';
import '../modules/panduan_instalasi/bindings/panduan_instalasi_binding.dart';
import '../modules/panduan_instalasi/views/panduan_instalasi_view.dart';
import '../modules/pengumuman/bindings/pengumuman_binding.dart';
import '../modules/pengumuman/views/pengumuman_view.dart';
import '../modules/product/bindings/product_binding.dart';
import '../modules/product/views/product_view.dart';
import '../modules/reg_pusat/bindings/reg_pusat_binding.dart';
import '../modules/reg_pusat/views/reg_pusat_view.dart';
import '../modules/role_akses/bindings/role_akses_binding.dart';
import '../modules/role_akses/views/role_akses_view.dart';
import '../modules/role_akses_1/bindings/role_akses_1_binding.dart';
import '../modules/role_akses_1/views/role_akses_1_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/menus setting/bonus_karyawan/bindings/bonus_karyawan_binding.dart';
import '../modules/settings/views/menus setting/bonus_karyawan/views/bonus_karyawan_view.dart';
import '../modules/settings/views/menus setting/buku_bank/bindings/buku_bank_binding.dart';
import '../modules/settings/views/menus setting/buku_bank/views/buku_bank_view.dart';
import '../modules/settings/views/menus setting/data_diri/bindings/data_diri_binding.dart';
import '../modules/settings/views/menus setting/data_diri/views/data_diri_view.dart';
import '../modules/settings/views/menus setting/keamanan/bindings/keamanan_binding.dart';
import '../modules/settings/views/menus setting/keamanan/views/keamanan_view.dart';
import '../modules/settings/views/menus setting/password/bindings/password_binding.dart';
import '../modules/settings/views/menus setting/password/views/password_view.dart';
import '../modules/settings/views/menus%20setting/pengaturan/bindings/pengaturan_binding.dart';
import '../modules/settings/views/menus%20setting/pengaturan/views/pengaturan_view.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/standar_teknik/bindings/standar_teknik_binding.dart';
import '../modules/standar_teknik/views/standar_teknik_view.dart';
import '../modules/surat_direksi/bindings/surat_direksi_binding.dart';
import '../modules/surat_direksi/views/surat_direksi_view.dart';
import '../modules/surat_internal/bindings/surat_internal_binding.dart';
import '../modules/surat_internal/views/surat_internal_view.dart';
import '../modules/user/bindings/user_binding.dart';
import '../modules/user/views/user_view.dart';

// ignore_for_file: constant_identifier_names
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.APP,
      page: () => const AppView(),
      binding: AppBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/val_pengajuan_dep',
      page: () => ValPengajuanDepView(),
      binding: ValPengajuanDepBinding(),
    ),

    GetPage(
      name: _Paths.ABSENCE,
      page: () => AbsenceView(),
      binding: AbsenceBinding(),
    ),
    GetPage(
      name: _Paths.PRODUCT,
      page: () => const ProductView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: Routes.FORM_BUILDING_HRD,
      page: () => const FormHrdView(),
      binding: FormBuildingHrdBinding(),
    ),
    GetPage(
      name: Routes.SELECT_LOCATION,
      page: () => const SelectLocationView(),
      binding: FormBuildingHrdBinding(),
    ),
    GetPage(
      name: _Paths.REG_PUSAT,
      page: () => RegPusatView(),
      binding: RegPusatBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    // GetPage(
    //   name: _Paths.SPLASH_SCREEN,
    //   page: () => SplashScreenView(),
    //   binding: SplashScreenBinding(),
    // ),
    GetPage(
      name: _Paths.KASBON,
      page: () => KasbonView(),
      binding: KasbonBinding(),
    ),
    GetPage(
      name: _Paths.add_building_hrd,
      page: () => AddBuildingHrdView(),
      binding: FormBuildingHrdBinding(),
    ),
    GetPage(
      name: _Paths.USER,
      page: () => const UserView(),
      binding: UserBinding(),
    ),
    GetPage(
      name: _Paths.MENU_EDIT,
      page: () => MenuEditView(),
      binding: MenuEditBinding(),
    ),
    GetPage(
      name: _Paths.BONUS_KARYAWAN,
      page: () => BonusKaryawanView(),
      binding: BonusKaryawanBinding(),
    ),

    GetPage(
      name: _Paths.BUKU_BANK,
      page: () => BukuBankView(),
      binding: BukuBankBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD,
      page: () => const PasswordView(),
      binding: PasswordBinding(),
    ),
    GetPage(
      name: _Paths.DATA_DIRI,
      page: () => DataDiriView(),
      binding: DataDiriBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PIN,
      page: () => LoginPinView(),
      binding: LoginPinBinding(),
    ),
    GetPage(
      name: _Paths.KEAMANAN,
      page: () => const KeamananView(),
      binding: KeamananBinding(),
    ),
    // GetPage(
    //   name: _Paths.CAPAIAN_KINERJA,
    //   page: () => CapaianKinerjaView(),
    //   binding: CapaianKinerjaBinding(),
    // ),
    GetPage(
      name: Routes.FORM_PENGAJUAN,
      page: () => const FormPengajuanHrdView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => FormPengajuanController());
      }),
    ),
    GetPage(
      name: _Paths.MONITORING_PROYEK,
      page: () => MonitoringProyekView(),
      binding: MonitoringProyekBinding(),
    ),
    GetPage(
      name: _Paths.HARGA_MODAL_LOGISTIK,
      page: () => HargaModalLogistikView(),
      binding: HargaModalLogistikBinding(),
    ),
    GetPage(
      name: _Paths.NOTULEN,
      page: () => const NotulenView(),
      binding: NotulenBinding(),
    ),

    GetPage(
      name: _Paths.BROSUR_LOGISTIK,
      page: () => BrosurLogistikView(),
      binding: BrosurLogistikBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_TKDN,
      page: () => DaftarTkdnView(),
      binding: DaftarTkdnBinding(),
    ),
    GetPage(
      name: _Paths.SURAT_DIREKSI,
      page: () => SuratDireksiView(),
      binding: SuratDireksiBinding(),
    ),
    GetPage(
      name: _Paths.JOB_DESK,
      page: () => JobDeskView(),
      binding: JobDeskBinding(),
    ),
    // GetPage(
    //   name: _Paths.CAPAIAN,
    //   page: () => const CapaianView(),
    //   binding: CapaianBinding(),
    // ),
    GetPage(
      name: _Paths.SURAT_INTERNAL,
      page: () => SuratInternalView(),
      binding: SuratInternalBinding(),
    ),
    GetPage(
      name: _Paths.DATA_MANDOR,
      page: () => DataMandorView(),
      binding: DataMandorBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_AKSES,
      page: () => RoleAksesView(),
      binding: RoleAksesBinding(),
    ),
    GetPage(
      name: _Paths.PENGATURAN,
      page: () => const PengaturanView(),
      binding: PengaturanBinding(),
    ),
    GetPage(
      name: _Paths.ANGGARAN_DEPARTEMEN,
      page: () =>   AnggaranDepartemenView(),
      binding: AnggaranDepartemenBinding(),
    ),
    GetPage(
      name: _Paths.COMPANY_PROFILE,
      page: () => const CompanyProfileView(),
      binding: CompanyProfileBinding(),
    ),
    GetPage(
      name: _Paths.PANDUAN_INSTALASI,
      page: () => const PanduanInstalasiView(),
      binding: PanduanInstalasiBinding(),
    ),
    GetPage(
      name: _Paths.PENGUMUMAN,
      page: () => PengumumanView(),
      binding: PengumumanBinding(),
    ),
    GetPage(
      name: _Paths.STANDAR_TEKNIK,
      page: () => StandarTeknikView(),
      binding: StandarTeknikBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_AKSES_1,
      page: () => const RoleAkses1View(),
      binding: RoleAkses1Binding(),
    ),
  ];
}
