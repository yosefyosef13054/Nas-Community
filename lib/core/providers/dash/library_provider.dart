import 'package:flutter/material.dart';

class LibraryProvider extends ChangeNotifier {
  late TabController _tabController;
  late TabController _classDetailsTabController;
  int _classDetailsIndex = 0;


  int get classDetailsIndex => _classDetailsIndex;

  set setClassDetailsIndex(int value) {
    _classDetailsIndex = value;
    notifyListeners();
  }


  set setClassDetailsIndexSilent(int value) {
    _classDetailsIndex = value;
  }

  TabController get tabController => _tabController;

  set setTabController(TabController value) {
    _tabController = value;
  }



  TabController get classDetailsTabController => _classDetailsTabController;

  set setClassDetailsTabController(TabController value) {
    _classDetailsTabController = value;
  }



  void notify (){
    notifyListeners();
  }
}