// import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
// import 'package:nas_academy/core/modules/community/community/community.dart';
//
// class CommunityResponse {
//
//   List<Community> communities;
//   List<ActiveCommunity> activeCommunity;
//
//   CommunityResponse({
//       this.communities = const [],
//       this.activeCommunity = const []});
//
//   factory CommunityResponse.fromMap (Map<String, dynamic> data){
//     return CommunityResponse(
//       activeCommunity: List.from(((data["activeCommunity"] is Iterable<dynamic>) ? data["activeCommunity"] ?? []: [data["activeCommunity"]]) ).map((e) => ActiveCommunity.fromMap(e)).toList(),
//       communities: List.from(data["communities"] ?? []).map((e) => Community.fromMap(e)).toList()
//     );
//   }
//
//
//   Map<String, dynamic> toMap (){
//     return {
//       "activeCommunity" : activeCommunity.map((e) => e.toMap()).toList(),
//       "communities" : communities.map((e) => e.toMap()).toList()
//     };
//   }
//
// }