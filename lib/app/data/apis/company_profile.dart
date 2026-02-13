part of 'api.dart';

class CompanyProfileApi extends Fetchly {
  Future<Response> getData([Map<String, dynamic>? query]) async =>
      get('company-profile', query);
  Future<Response> createData(Map<String, dynamic> data) async =>
      post('company-profile', data);

      
  Future<Response> updateData(Map<String, dynamic> data, int id) async =>
     post('company-profile/$id?_method=PATCH', data.toFormData());


  Future<Response> getDataId(int id) async => get('company-profile/$id');
  Future<Response> deleteData(int id) async => delete('company-profile/$id');
}
