import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/dash/members/components/member_card.dart';
import 'package:nas_academy/ui/dash/members/nas_team/nas_team_members.dart';
import 'package:provider/provider.dart';


class AllMembers extends StatelessWidget {
  const AllMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final members = Provider.of<MembersProvider>(context);
    if(dash.fullMembersList.isNotEmpty){
      final List<Member> filtered = dash.fullMembersList.where((member) => members.filter(member)).toList();
      if(filtered.isNotEmpty){
        return Column(
          children: filtered.map((e) => MemberCard(member: e, joiningDate: false,)).toList(),
        );
      }else {
        return const NoResultsFound();
      }
    }else {
      return const EmptyState();
    }

  }
}
