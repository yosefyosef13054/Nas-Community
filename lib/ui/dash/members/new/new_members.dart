import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/dash/members/components/member_card.dart';
import 'package:nas_academy/ui/dash/members/nas_team/nas_team_members.dart';
import 'package:nas_academy/ui/dash/members/new/new_members_tip.dart';
import 'package:provider/provider.dart';

class NewMembers extends StatefulWidget {
  const NewMembers({Key? key}) : super(key: key);

  @override
  State<NewMembers> createState() => _NewMembersState();
}

class _NewMembersState extends State<NewMembers> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dash = Provider.of<DashProvider>(context);
    final members = Provider.of<MembersProvider>(context);
    return Column(
      children: [
        const NewMembersTip(),
        Builder(builder: (context){
          if(dash.newMembers().isNotEmpty){
            final List<Member> filtered = dash.newMembers().where((member) => members.filter(member)).toList();
            if(filtered.isNotEmpty){
              return Column(children: filtered.map((e) => MemberCard(
                member: e,
                joiningDate: true,
              ))
                  .toList(),
              );
            }else {
              return const NoResultsFound();
            }
          }else {
            return const Center(
              child: EmptyState(),
            );
          }
        }),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
