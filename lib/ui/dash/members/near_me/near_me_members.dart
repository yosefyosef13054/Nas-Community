import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/services/permission_handler.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/dash/members/components/member_card.dart';
import 'package:nas_academy/ui/dash/members/nas_team/nas_team_members.dart';
import 'package:nas_academy/ui/dash/members/near_me/near_me_tip.dart';
import 'package:provider/provider.dart';


class NearMeMembers extends StatefulWidget {
  const NearMeMembers({Key? key}) : super(key: key);

  @override
  State<NearMeMembers> createState() => _NearMeMembersState();
}

class _NearMeMembersState extends State<NearMeMembers> with AutomaticKeepAliveClientMixin{

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final dash = Provider.of<DashProvider>(context,);
    final members = Provider.of<MembersProvider>(context);
    return StreamBuilder<bool>(
      stream: PermissionHandlerService.locationEnabledStream(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          return Column(
            children: [
              Visibility(
                visible: dash.loading,
                child: const LinearProgressIndicator(
                  minHeight: 1.5,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
                ),
              ),
              Visibility(visible: snapshot.data != true, child: const NearMeTip()),
              snapshot.data == true ? FutureBuilder<List<Member>>(
                future: dash.nearMe(),
                builder: (context, snapshot){
                  if(snapshot.hasData && snapshot.data != null){
                    if(snapshot.data!.isNotEmpty){
                      List<Member> nearMe = snapshot.data!.where((member) => members.filter(member)).toList();
                      if(nearMe.isNotEmpty){
                        return  Column(children: nearMe.map((e) => MemberCard(member: e, joiningDate: false,)).toList(),);
                      }else {
                        return const NoResultsFound();
                      }
                    }else {
                      return const EmptyState();
                    }
                  }else {
                    return const Align(
                      alignment: Alignment.topCenter,
                      child: LinearProgressIndicator(
                        minHeight: 1.5,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
                      ),
                    );
                  }
                },
              ) : Column(
                mainAxisSize: MainAxisSize.min,
                children:const  [
                  SizedBox(height: 60,),
                  Icon(LineIcons.mapMarker, size: 100, color: ColorPlate.tertiaryLightBG,),
                  SizedBox(height: 30,),
                  Text("Location permission is needed ..", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: ColorPlate.tertiaryLightBG),),
                ],
              ),
            ],
          );
        }else {
          return const Align(
            alignment: Alignment.topCenter,
            child: LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          );
        }
      }
    );
  }

  @override
  bool get wantKeepAlive => true;
}
