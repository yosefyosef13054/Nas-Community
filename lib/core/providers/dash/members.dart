import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/member/followers_range.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/utils/data_type.dart';

class MembersProvider extends ChangeNotifier{

  List<String> countries = [];
  List<String> skills = [];
  List<String> socialPlatform = [];
  FollowersRange? _followersCount;
  int _filtersIndex = 0;
  int get filtersIndex => _filtersIndex;
  bool _memberRole = false;
  bool  _managerRole = false;
  bool _filtering = false;


  bool get filtering => _filtering;

  set setFiltering(bool value) {
    _filtering = value;
    notifyListeners();
  }

  FollowersRange? get followersCount => _followersCount;

  set setFollowersCount(FollowersRange? value) {
    _followersCount = value;
    notifyListeners();
  }

  bool get memberRole => _memberRole;

  set setMemberRole(bool value) {
    _memberRole = value;
    notifyListeners();
  }

  set setFiltersIndex(int value) {
    _filtersIndex = value;
   notifyListeners();
  }



  BorderRadius borderRadius (){
    switch (filtersIndex) {
      case 0:
      case 1:
       return const BorderRadius.only(
         topLeft: Radius.circular(28),
         topRight: Radius.circular(28),
       );
      case 2 :
      case 3 : return BorderRadius.zero;
      default : return BorderRadius.zero;
    }
  }


  void notify (){
    notifyListeners();
  }

  bool get managerRole => _managerRole;

  set setManagerRole(bool value) {
    _managerRole = value;
    notifyListeners();
  }


  bool valid (){
    return _managerRole || _memberRole || _followersCount != null || countries.isNotEmpty || skills.isNotEmpty || socialPlatform.isNotEmpty;
  }


  void applyFilters (BuildContext context){
    setFiltering = true;
    Navigator.pop(context);
  }


  void resetFilters (){
    _managerRole = false;
    _memberRole = false;
    _followersCount = null;
    countries.clear();
    skills.clear();
    socialPlatform.clear();
    _filtering = false;
    notifyListeners();
  }


  bool filter (Member member,){
    if(_filtering){
      return _countriesFilter(member) &&
          _skillsFilter(member) &&
          _socialPlatformFilter(member) &&
          _followersCountFilter(member) &&
          _roleFilter(member);
    }else {
      return true;
    }
  }


  bool _countriesFilter (Member member){
    if(countries.isNotEmpty){
      String country =  _format(member.country ?? "");
      return countries.any((element) => _format(element) == country);
    }else {
      return true;
    }
  }


  bool _skillsFilter (Member member){
    if(skills.isNotEmpty){
      List<String> _memberSkills = member.skills.map((e) => _format(e)).toList();
      return skills.any((skill) => _memberSkills.contains(_format(skill)));
    }else {
      return true;
    }
  }


  bool _socialPlatformFilter (Member member){
    if(socialPlatform.isNotEmpty){
      List<String> _memberSocials = member.socialMedia.map((e) => _format(e.type ?? "")).toList();
      return socialPlatform.any((skill) => _memberSocials.contains(_format(skill)));
    }else {
      return true;
    }
  }


  bool _followersCountFilter (Member member){
    if(_followersCount != null){
      int _totalFollowers = int.parse(member.followersCount.replaceAll(",", ""));
      return _totalFollowers >= followersCount!.min && _totalFollowers <= followersCount!.max;
    }else {
      return true;
    }
  }

  bool _roleFilter (Member member){
    if(_memberRole == _managerRole){
      return true;
    }else {
      if(_memberRole){
        return member.role == MemberRole.member;
      }else if(_managerRole){
        return member.role == MemberRole.communityManager;
      }else {
        return false;
      }
    }
  }


  String _format (String val){
    return val.toLowerCase().replaceAll(" ", "");
  }


}