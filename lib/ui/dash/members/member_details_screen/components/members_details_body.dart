import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_type.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/components/trainer_badge.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/communities_members_details.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/expandable_item.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/skills_member_details.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/social_media.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/spotlight.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/telegram.dart';

class MembersDetailsBody extends StatelessWidget {
  const MembersDetailsBody({Key? key, required this.member}) : super(key: key);
  final Member member;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, I’m ${member.firstName} ${member.lastName}",
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            Visibility(
              visible: member.country != null && member.country!.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "${member.country}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ),
            Visibility(
              visible: member.role == MemberRole.communityManager,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  height: 25,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: ColorPlate.blurple60),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset("assets/svg/nas_badge.svg"),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Community Manager",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Visibility(
              visible: member.role == MemberRole.trainer,
              child: const Padding(
                padding: EdgeInsets.only(top: 10),
                child: TrainerBadge(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AboutMemberDetails(
              sub: member.longDescription!.isNotEmpty
                  ? member.longDescription!
                  : member.description ?? "",
              userProfile: false,
            ),
            SkillsMemberDetails(
              list: member.skills,
              title: "Skills",
              bottomDivider: member.interests.isEmpty,
              topDivider: true,
              userProfile: false,
            ),
            SkillsMemberDetails(
              list: member.interests,
              title: "Interests",
              topDivider: member.skills.isEmpty,
              bottomDivider: true,
              userProfile: false,
            ),
            Spotlight(
              spotlight: SpotLight(link: member.spotlightLink),
              visible: member.spotlightLink != null &&
                  member.spotlightLink!.isNotEmpty,
              userProfile: false,
            ),
            SocialMediaMembers(
                socials: member.socialMedia,
                followers: int.tryParse(member.followersCount.replaceAll(",", "")) ?? 0,
                userProfile: false,
            ),
            TelegramMemberDetails(
              userProfile: true,
              email: member.email,
              telegramLink: member.telegramUsername,
            ),
            CommunitiesMemberDetails(list: member.subscriptions),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
