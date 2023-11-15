import 'package:halokak_app/data/remote/base_api.dart';
import 'package:halokak_app/models/responses/category_response.dart';

class HomeAPI extends BaseAPI {

  Future<CategoryResponse> getCategoryList() async {
    Map<String, String> queryParams = {};
    var requestUri = Uri.https(BaseAPI.host, categoryPath, queryParams);
    var response = await requestResponse(RM.get, requestUri, headers: getHeader());
    return CategoryResponse.from(response);
  }
}