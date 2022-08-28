import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/member_details_fab.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/members_details_body.dart';


class MemberDetailsScreen extends StatelessWidget {
  const MemberDetailsScreen(
      {Key? key, required this.member, this.booked})
      : super(key: key);
  final Member member;
  final bool? booked;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPlate.primaryDarkBG,
      floatingActionButton: MemberDetailsFab(member: member, booked: booked,),
      body : CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraint) {
              final bool showTitle = constraint.scrollOffset < 200 || (constraint.userScrollDirection == ScrollDirection.forward && constraint.scrollOffset < 350);
              return SliverAppBar(
                toolbarHeight: 65,
                backgroundColor: ColorPlate.primaryDarkBG,
                pinned: true,
                title : AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: showTitle? const SizedBox() :  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, size: 18,),
                        onPressed: ()=> Navigator.pop(context),
                      ),
                      const SizedBox(width: 5,),
                      CircleAvatar(backgroundImage: NetworkImage(member.profileImage!),),
                      const SizedBox(width: 20,),
                      Text("${member.firstName} ${member.lastName}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
                    ],
                  ),
                ),
                foregroundColor: ColorPlate.primaryLightBG,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                expandedHeight: 350,
                elevation: 1,
                collapsedHeight: 70,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  title: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: constraint.scrollOffset < 200 ? 30 : 0,
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                      color: ColorPlate.primaryDarkBG,
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  background: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.topLeft,
                    children: [
                      Image.network(
                        member.profileImage!,
                        fit: BoxFit.cover,
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: constraint.userScrollDirection == ScrollDirection.reverse ? const SizedBox() : Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 45, horizontal: 20),
                            child: InkWell(
                              onTap: ()=> Navigator.pop(context),
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: ColorPlate.light50),
                                child: const Center(
                                  child: Icon(Icons.close),
                                ),
                              ),
                            ),
                          ),),
                      ),
                    ],
                  ),
                ),
              );
            }
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              ConstrainedBox(
                constraints: BoxConstraints(minHeight:MediaQuery.of(context).size.height - 70 - MediaQuery.of(context).padding.top + 5),
                  child: MembersDetailsBody(member: member)),
            ]),
          ),
        ],
      )
    );
  }
}
