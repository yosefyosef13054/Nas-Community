import 'package:nas_academy/core/modules/member/meta.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/utils/data_type.dart';

class MembersResponse {
  List<Member> members;
  List<Member> communityMangers;
  MembersMeta? meta;

  MembersResponse(
      {this.members = const [], this.communityMangers = const [], this.meta});

  factory MembersResponse.fromMap(Map<String, dynamic> data) {
    return MembersResponse(
      meta: data["meta"] != null ? MembersMeta.fromMap(data["meta"]) : null,
      communityMangers: List.from(data["communityManagers"] ?? []).map((e) => Member.fromMap(e, MemberRole.communityManager)).toList(),
      members: List.from(data["data"] ?? []).map((e) => Member.fromMap(e, MemberRole.member)).toList()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "communityManagers": communityMangers.map((e) => e.toMap()).toList(),
      "meta": meta?.toMap(),
      "data": members.map((e) => e.toMap()).toList(),
    };
  }
}
