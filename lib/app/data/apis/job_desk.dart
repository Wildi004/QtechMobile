part of 'api.dart';

class JobDeskApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('job-desk', query);

  Future<Response> createData(Map<String, dynamic> data) async =>
      post('job-desk', data.toFormData());

  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
      post('job-desk/$id', {...data, '_method': 'patch'}.toFormData());

  Future<Response> deletetJob(int id) async => delete('job-desk/$id');
}
