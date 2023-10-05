import '../data/local/text_storage.dart';
import '../models/enum/navigation_enum.dart';
import 'base_provider.dart';

class NavigationProvider extends BaseProvider {
  NavigationItem _navigationItem = NavigationItem.home;
  NavigationItem? _previousNavItem;

  NavigationItem get navigationItem => _navigationItem;

  void setNavigationItem(NavigationItem navigationItem) {
    _previousNavItem = _navigationItem;
    _navigationItem = navigationItem;
    notifyListeners();
  }

  void backToPrevious() {
    if (_previousNavItem != null) {
      _navigationItem = _previousNavItem!;
      notifyListeners();
    }
  }

  String getAppBarTitle() {
    switch(_navigationItem) {
      case NavigationItem.home:
        return TextStorage.titleHome;
      case NavigationItem.login:
        return TextStorage.titleAuth;
      default:
        return "";
    }
  }
}