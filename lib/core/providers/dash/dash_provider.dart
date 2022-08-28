import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:geocoding/geocoding.dart';
import 'package:location/location.dart' as location;
import 'package:nas_academy/core/api/application/application_config.dart';
import 'package:nas_academy/core/api/community/community.dart';
import 'package:nas_academy/core/api/library/library.dart';
import 'package:nas_academy/core/modules/application/application_status.dart';
import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:nas_academy/core/modules/library/class/video_preview.dart';
import 'package:nas_academy/core/modules/library/resource/resource_preview.dart';
import 'package:nas_academy/core/modules/library/resource/video_resource.dart';
import 'package:nas_academy/core/modules/member/full_response.dart';
import 'package:nas_academy/core/api/members/members.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
import 'package:nas_academy/core/modules/community/community/community.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/services/permission_handler.dart';
import 'dart:developer';

import 'package:nas_academy/core/utils/data_types.dart';

class DashProvider extends ChangeNotifier {
  late PageController communitiesPageController;
  late PageController communityViewPageController;
  final ZoomDrawerController drawerController = ZoomDrawerController();
  int _communitiesIndex = 0;
  int _communityViewIndex = 0;
  List<Community> _communities = [];

  /// members
  List<Member> members = [];
  List<Member> communityMangers = [];
  List<Member> fullMembersList = [];
  late TabController _membersTabController;
  final location.Location _location = location.Location();
  location.LocationData? _locationData;
  String? _country;


  /// library
  List<VideoClass> libraryClasses = [];
  List<VideoResource> libraryResources = [];
  List<VideoPreview> libraryVideoPreviews = [];
  List<ResourcePreview> libraryResourcePreviews = [];

  /// application
  List<ApplicationStatus> statusList = [];
  bool _loading = false;

  ActiveCommunity? _activeCommunity;

  ActiveCommunity? get activeCommunity => _activeCommunity;

  Future setActiveCommunity(ActiveCommunity value) async {
    if (activeCommunity == null || value.id != activeCommunity!.id) {
      _activeCommunity = value;
      await Future.delayed(const Duration(milliseconds: 100));
      notifyListeners();
    }
  }

  bool get loading => _loading;

  set setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  TabController get membersTabController => _membersTabController;

  set setMembersTabController(TabController value) {
    _membersTabController = value;
  }

  int get communityViewIndex => _communityViewIndex;

  set setCommunityViewIndex(int value) {
    _communityViewIndex = value;
    notifyListeners();
  }



  int get communitiesIndex => _communitiesIndex;

  set setCommunitiesIndex(int value) {
    _communitiesIndex = value;
    notifyListeners();
  }

  set setCommunitiesIndexSilent(int value) {
    _communitiesIndex = value;
  }

  List<Community> get communities => _communities;

  set setCommunities(List<Community> value) {
    _communities = value;
    notifyListeners();
  }

  Future init({bool? resetIndex}) async {
    setCommunities = await CommunityApi().getCommunities();
    statusList = await ApplicationConfigsAPI().getApplicationStatus();
    for (Community community in communities) {
      List<ApplicationStatus> status = statusList.where((element) => element.communityCode == community.code).toList();
      if (status.isEmpty) {
        communities.removeWhere((element) => element.id == community.id);
      } else {
        ApplicationStatus stat = status.first;
        community.status = stat.communitySubscriptionStatus!;
      }
    }
    if(resetIndex != false){
      setCommunitiesIndexSilent = firstIndex();
    }
    await UserLocalDB.initNearMeTip();
  }

  void onCommunityChange(int index) {
    members.clear();
    communityMangers.clear();
    libraryClasses.clear();
    libraryVideoPreviews.clear();
    libraryResources.clear();
    libraryResourcePreviews.clear();
    setCommunitiesIndex = index;
    setCommunityViewIndex = 0;
    communityViewPageController.jumpToPage(0);
  }

  Future getMembers() async {
    if (members.isEmpty || communityMangers.isEmpty) {
      String communityID = _activeCommunity!.id!;
      MembersResponse response =
          await const MembersApi().getMembers(communityID);
      members = response.members
          .where((element) =>
              element.firstName != null &&
              element.lastName != null &&
              element.profileImage != null)
          .toList();
      communityMangers = response.communityMangers
          .where((element) =>
              element.firstName != null &&
              element.lastName != null &&
              element.profileImage != null)
          .toList();
      fullMembersList = members + communityMangers;
      fullMembersList.shuffle();
    }
  }

  List<Member> newMembers() {
    return members.where((element) => element.isNew()).toList();
  }

  Future<List<Member>> nearMe() async {
    try {
      _loading = true;
      final String? currentCountry = await getCurrentCountryName();
      _loading = false;
      if (currentCountry != null) {
        return (members + communityMangers)
            .where((element) =>
                (element.country ?? "").toLowerCase().replaceAll(" ", "") ==
                currentCountry)
            .toList();
      } else {
        return [];
      }
    } catch (e) {
      log("ERROR getting country name : ${e.toString()}");
      _loading = false;
      rethrow;
    }
  }

  Future<String?> getCurrentCountryName() async {
    if (_country == null) {
      final bool enabled = await PermissionHandlerService.locationEnabled();
      if (enabled) {
        _locationData ??= await _location.getLocation();
        List<Placemark> places = await placemarkFromCoordinates(
            _locationData!.latitude!, _locationData!.longitude!);
        _country = places
            .where((element) => element.country != null)
            .first
            .country!
            .toLowerCase()
            .replaceAll(" ", "");
      }
    }
    return _country;
  }

  void notify() {
    notifyListeners();
  }

  Future initLibrary() async {
    if (activeCommunity != null) {
      if (libraryVideoPreviews.isEmpty) {
        libraryVideoPreviews = await const LibraryAPIs()
            .getClassPreviews(communityID: activeCommunity!.id!);
      }
      if (libraryResourcePreviews.isEmpty) {
        libraryResourcePreviews = await const LibraryAPIs()
            .getResourcePreviews(communityID: activeCommunity!.id!);
      }
      if (libraryResources.isEmpty) {
        libraryResources = await const LibraryAPIs()
            .getResources(communityID: activeCommunity!.id!);
      }
      if (libraryClasses.isEmpty) {
        libraryClasses = await const LibraryAPIs()
            .getVideoClasses(communityID: activeCommunity!.id!);
        for (var vidClass in libraryClasses) {
          vidClass.items.removeWhere((element) => element.link == null);
        }
        for (VideoClass videoClass in libraryClasses) {

          List<VideoPreview> prev = libraryVideoPreviews
              .where((element) => element.topic == videoClass.topic)
              .toList();
          if (prev.isNotEmpty) {
            videoClass.preview = prev.first;
          }
        }
      }
    }
  }

  int firstIndex() {
    if (communities
        .any((element) => element.status == ApplicationStatusType.current)) {
      return communities.indexWhere(
          (element) => element.status == ApplicationStatusType.current);
    } else {
      return communities.length;
    }
  }
}
