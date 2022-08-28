import 'package:dio/dio.dart';
import 'package:nas_academy/core/helpers/dio_api.dart';
import 'package:nas_academy/core/modules/category/category.dart';
import 'dart:developer';

class CategoryApi {
  DioService dioServices = DioService();
  List<Category> questionsCategorieslist = [];

  // onboarding questions categories
  Future<List<Category>> getCategoriesapi() async {
    try {
      var response = await dioServices.get('course-categories');
      questionsCategorieslist =
          List<Category>.from(response.data.map((x) => Category.fromJson(x)));
    } on DioError catch (e) {
      log(e.toString());
    }
    return questionsCategorieslist;
  }
}
