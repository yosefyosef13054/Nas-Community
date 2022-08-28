import 'package:nas_academy/core/utils/extensions.dart';

class FollowersRange {
  int min;
  int max;
  String id;

  FollowersRange({required this.min,required this.max, required this.id});

  @override
  String toString() {
    if(min > 5000000 || max > 5000000) {
      return "5M+";
    }else {
      return "${numberToString(min)} - ${numberToString(max)}";
    }
  }

  String numberToString (int val){
    if(val < 10000){
      return val.toString();
    }else if (val >= 10000 && val < 1000000){
      return "${val~/1000}K";
    }else if (val >= 1000000 && val <= 5000000){
      return "${val~/1000000}M";
    }else if (val > 5000000){
      return "${val~/1000000}M";
    } else {
      return val.toInt().thousandFormat;
    }
  }
}