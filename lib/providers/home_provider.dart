import 'package:halokak_app/data/remote/home_api.dart';

import 'base_provider.dart';

class HomeProvider extends BaseProvider {
  final HomeAPI _homeAPI = HomeAPI();

  List<Map<String, dynamic>> categoryList = [];

  List<Map<String, dynamic>> mentorList = [];

  HomeProvider() {
    initData();
  }

  void initData() {
    fetchCategoryList();
    fetchMentorList();
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

  Future<void>? fetchMentorList() async {
    try {
      var response = await _homeAPI.getRecommendMentorList();
      mentorList = response.data ?? [];
    } on Exception catch (e) {
      logData(e.toString());
    } finally {
      notifyListeners();
    }
  }
}