part of 'api.dart';

class RkApi extends Fetchly {
  //HRD
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('hrd/laporan-kerja', query);

  Future<Response> getDetail(String encryptedMinggu,
          [Map<String, dynamic>? query]) async =>
      get('hrd/laporan-kerja/list/$encryptedMinggu', query);

  Future<Response> getRkPic(String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('hrd/laporan-kerja/list/sub-list/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> sendToTelegram(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('hrd/laporan-kerja/list/sub-list/send-to-telegram/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> getRkPicDetail(int id) async =>
      get('hrd/laporan-kerja/list/sub-list/detail/$id');

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('hrd/laporan-kerja', data);
//IT

  Future<Response> getDataIt([Map<String, dynamic>? query]) async =>
      get('it/laporan-kerja', query);

  Future<Response> getMingguIt(String encryptedMinggu,
          [Map<String, dynamic>? query]) async =>
      get('it/laporan-kerja/list/$encryptedMinggu', query);

  Future<Response> getTanggalIt(String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('it/laporan-kerja/list/sub-list/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> getLaporanIt([Map<String, dynamic>? query]) async =>
      get('bsd/settings/kategori-rk/list', query);

  Future<Response> sendToTelegramIt(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('it/laporan-kerja/list/sub-list/send-to-telegram/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> createDataIt(Map<String, dynamic> data) async =>
      post('it/laporan-kerja', data);

  Future<Response> deleteData(int id) async => delete('path/$id');

  //Legal
  Future<Response> getDataLegal([Map<String, dynamic>? query]) async =>
      get('legal/laporan-kerja', query);

  Future<Response> getMingguLegal(String encryptedMinggu,
          [Map<String, dynamic>? query]) async =>
      get('legal/laporan-kerja/list/$encryptedMinggu', query);

  Future<Response> getTanggalLegal(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('legal/laporan-kerja/list/sub-list/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> sendToTelegramLegal(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('legal/laporan-kerja/list/sub-list/send-to-telegram/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> getLaporan([Map<String, dynamic>? query]) async =>
      get('bsd/settings/kategori-rk/list', query);

  Future<Response> createDataLegal(Map<String, dynamic> data) async =>
      post('legal/laporan-kerja', data);

  // Logistik

  Future<Response> getDataLogistik([Map<String, dynamic>? query]) async =>
      get('logistik/laporan-kerja', query);

  Future<Response> getMingguLogistik(String encryptedMinggu,
          [Map<String, dynamic>? query]) async =>
      get('logistik/laporan-kerja/list/$encryptedMinggu', query);

  Future<Response> getTanggalLogistik(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('logistik/laporan-kerja/list/sub-list/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> sendToTelegramLogistik(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('logistik/laporan-kerja/list/sub-list/send-to-telegram/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> createLogistik(Map<String, dynamic> data) async =>
      post('logistik/laporan-kerja', data);

  //RND
  Future<Response> getDataRnd([Map<String, dynamic>? query]) async =>
      get('rnd/laporan-kerja', query);
  Future<Response> getMingguRnd(String encryptedMinggu,
          [Map<String, dynamic>? query]) async =>
      get('rnd/laporan-kerja/list/$encryptedMinggu', query);
  Future<Response> getLaporanRnd([Map<String, dynamic>? query]) async =>
      get('bsd/settings/kategori-rk/list', query);

  Future<Response> createDataRnd(Map<String, dynamic> data) async =>
      post('rnd/laporan-kerja', data);
  Future<Response> getTanggalRnd(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('rnd/laporan-kerja/list/sub-list/$encryptedTglRencana/$encryptedPic',
          query);

  Future<Response> sendToTelegramRnd(
          String encryptedTglRencana, String encryptedPic,
          [Map<String, dynamic>? query]) async =>
      get('rnd/laporan-kerja/list/sub-list/send-to-telegram//$encryptedTglRencana/$encryptedPic',
          query);
}
