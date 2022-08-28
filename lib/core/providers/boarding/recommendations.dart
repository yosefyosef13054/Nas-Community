import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nas_academy/core/api/category/category.dart';
import 'package:nas_academy/core/modules/category/category.dart';

class RecommendationsProvider extends ChangeNotifier {
  final CategoryApi _categoryApi;
  RecommendationsProvider(this._categoryApi);
  List<Category> categoriesList = [];
  List<Category> selectedCats = [];
  List<SubCategory> selectedSubCat = [];
  late PageController _pageController;
  int _index = 0;
  Timer? timer;




  PageController get pageController => _pageController;

  set setPageController(PageController value) {
    _pageController = value;
  }

  int get index => _index;

  set setIndex(int value) {
    _index = value;
    notifyListeners();
  }

  bool validToNext() {
    if (index == 0) {
      return selectedCats.isNotEmpty;
    } else if (index == 1) {
      return selectedSubCat.isNotEmpty;
    }else {
      return false;
    }
  }

  void notify() {
    notifyListeners();
  }

  Future getCategories() async {
    categoriesList = await _categoryApi.getCategoriesapi();
  }


  Future getCourses ()async{
    timer = Timer(const Duration(seconds: 2), (){});
    /// remove the dummy future below and add the get request for courses
    await Future.delayed(const Duration(seconds: 1));
    pageController.animateToPage(_index + 1, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
  }

}
