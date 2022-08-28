import 'package:nas_academy/core/modules/community/subs/community_video.dart';
import 'package:nas_academy/core/modules/community/subs/platform.dart';
import 'package:nas_academy/core/modules/community/active_community/thumb_nail_image.dart';
import 'package:nas_academy/core/modules/community/subs/upcoming_evets.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/utils/data_type.dart';


class ActiveCommunity {
  String? id;
  String? title;
  List<String> featuredMemberIds;
  ThumbnailImgData? thumbnailImgData;
  String? by;
  List<UpcomingEvent> upcomingEvents;
  List<Member> featuredMembers;
  List<CommunityVideo> communityVideos;
  List<MediaPlatform> platforms;
  Member? trainer;


  ActiveCommunity({
    this.id = "",
    this.title = "",
    this.thumbnailImgData,
    this.by = '',
    this.trainer,
    this.featuredMembers = const [],
    this.featuredMemberIds = const [],
    this.upcomingEvents = const [],
    this.communityVideos = const [],
    this.platforms = const [],
  });

  factory ActiveCommunity.fromMap (Map<String, dynamic> data){
    return ActiveCommunity(
      id: data["_id"],
      title: data["title"],
      thumbnailImgData: data["thumbnailImgData"] != null ? ThumbnailImgData.fromMap(data["thumbnailImgData"]) : null,
      by: data["by"] ?? data["By"] ?? "",
      trainer: data["trainer"] != null ? Member.fromMap(data["trainer"], MemberRole.trainer) : null,
      featuredMembers: data["featuredMembers"] == null? [] : data["featuredMembers"] is Iterable<dynamic>? List.from(data["featuredMembers"] ?? []).map((e) => Member.fromMap(e, MemberRole.member)).toList() : [Member.fromMap(data["featuredMembers"], MemberRole.member)],
      featuredMemberIds: data["featuredMemberIds"] is Iterable ? List.from(data["featuredMemberIds"] ?? []).map((e) => e.toString()).toList() : [],
      upcomingEvents: List.from(data["upcomingEvents"] ?? []).map((e) => UpcomingEvent.fromMap(e)).toList(),
      communityVideos: List.from(data["communityVideos"] ?? []).map((e) => CommunityVideo.fromMap(e)).toList(),
      platforms: List.from(data["platforms"] ?? []).map((e) => MediaPlatform.fromMap(e)).toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "title": title,
      "featuredMemberIds": featuredMemberIds,
      "thumbnailImgData": thumbnailImgData?.toMap(),
      "by": by,
      "trainer" : trainer?.toMap(),
      "upcomingEvents": upcomingEvents.map((e) => e.toMap()).toList(),
      "featuredMembers": featuredMembers.map((e) => e.toMap()).toList(),
      "communityVideos": communityVideos.map((e) => e.toMap()).toList(),
      "platforms" : platforms.map((e) => e.toMap()).toList()
    };
  }
}
