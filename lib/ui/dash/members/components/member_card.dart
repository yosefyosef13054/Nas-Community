import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_type.dart';
import 'package:nas_academy/ui/dash/members/components/nas_team_badge.dart';
import 'package:nas_academy/ui/dash/members/components/new_badge.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/members_details_screen.dart';
import 'package:provider/provider.dart';



class MemberCard extends StatelessWidget {
  const MemberCard({Key? key, required this.member, required this.joiningDate}) : super(key: key);
  final Member member;
  final bool joiningDate;
  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return InkWell(
      onTap: (){
        Navigate.push(context, ChangeNotifierProvider<MembersProvider>.value(
            value : membersProvider,
            child: MemberDetailsScreen(member: member,),
        ));
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: CircleAvatar(
                radius: 32,
                backgroundImage: NetworkImage(member.profileImage!),
              ),
            ),
            const SizedBox(width: 15,),
            Expanded(
              flex: 4,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("${member.firstName} ${member.lastName}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
                      NewBadge(show: member.isNew()),
                      NasTeamBadge(show: member.role == MemberRole.communityManager),
                    ],
                  ),
                  const SizedBox(height: 3,),
                  Visibility(
                      visible: member.country != null && member.country!.isNotEmpty,
                      child: Text(member.country ?? "", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.secondaryLightBG),)),
                  const SizedBox(height: 10,),
                  Visibility(
                      visible: member.description != null && member.description!.isNotEmpty,
                      child: Text("${member.description}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.primaryLightBG),)),
                  Visibility(
                    visible: joiningDate && member.joiningDate() != null,
                    child:  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child:Text("Joined ${DateTime.now().difference(member.joiningDate() ?? DateTime.now()).inDays} days ago", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: ColorPlate.secondaryLightBG),),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
