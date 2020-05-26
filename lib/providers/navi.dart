import 'package:flutter/material.dart';

class NaviProvider with ChangeNotifier {
  int _currentIndex = 0;
  bool _showAppbar = false;
  String _appBarTitle = '';

  // NaviProvider(int index, bool show, String title) {
  //   _currentIndex = index;
  //   _showAppbar = show;
  //   _appBarTitle = title;
  // }

  get currentIndex => _currentIndex;

  get showAppbar => _showAppbar;

  get appBarTitle => _appBarTitle;

  void setActiveIndex(int index, bool show, String title) {
    _currentIndex = index;
    _showAppbar = show;
    _appBarTitle = title;
    notifyListeners();
  }

  set currentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  set showAppbar(bool show) {
    _showAppbar = show;
    notifyListeners();
  }

  set appBarTitle(String title) {
    _appBarTitle = title;
    notifyListeners();
  }
}
