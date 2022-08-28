import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/dash/members/components/member_card.dart';
import 'package:provider/provider.dart';


class NasTeamMembers extends StatelessWidget {
  const NasTeamMembers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final members = Provider.of<MembersProvider>(context);
    if(dash.communityMangers.isNotEmpty){
      List<Member> filtered = dash.communityMangers.where((member) => members.filter(member)).toList();
      if (filtered.isNotEmpty){
        return Column(
          children: filtered.map((e) => MemberCard(member:e, joiningDate: false)).toList(),
        );
      }else {
        return const NoResultsFound();
      }
    }else {
      return const Center(
        child: EmptyState(),
      );
    }
  }
}



class NoResultsFound extends StatelessWidget {
  const NoResultsFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:[
        const  SizedBox(height: 80,),
        const  Icon(LineIcons.search, size: 100, color: ColorPlate.tertiaryLightBG,),
        const  SizedBox(height: 50,),
        const  Text("No results found ..", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: ColorPlate.tertiaryLightBG),),
        const  SizedBox(height: 20,),
        ElevatedButton(
            style: ButtonStyle(
                elevation: MaterialStateProperty.all(0)
            ),
            onPressed: (){members.resetFilters();},
            child: const Text("Reset Filters")),
      ],
    );
  }
}

