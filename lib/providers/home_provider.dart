import 'package:halokak_app/data/remote/home_api.dart';

import 'base_provider.dart';

class HomeProvider extends BaseProvider {
  final HomeAPI _homeAPI = HomeAPI();

  List<Map<String, dynamic>> categoryList = [
    {
      "nama": "Dokter",
    },
    {
      "nama": "Matematika",
      "photo": "https://picsum.photos/250?image=9"
    },
    {
      "nama": "Programmer",
    },
    {
      "nama": "Scientist",
      "photo": "https://picsum.photos/250?image=9"
    },
  ];

  HomeProvider() {
    initData();
  }

  void initData() {
    fetchCategoryList();
  }

  Future<void>? fetchCategoryList() async {
    try {
      var response = await _homeAPI.getCategoryList();
      categoryList = response.data ?? [];
    } on Exception catch (e) {
      logData(e.toString());
    } finally {
      notifyListeners();
    }
  }
}