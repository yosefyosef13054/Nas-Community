import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/expandable_item.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/skills_member_details.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/social_media.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/spotlight.dart';
import 'package:nas_academy/ui/dash/user_profile/profile/complete_your_profile/complete_your_profile.dart';
import 'package:nas_academy/ui/dash/user_profile/profile/contacts.dart';

class UserProfileBody extends StatelessWidget {
  const UserProfileBody({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                "Hi, I’m ${user.learner.firstName} ${user.learner.lastName ?? ''}",
                style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            Visibility(
              visible: user.country != null && user.country!.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                child: Text(
                  "${user.country}",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            const CompleteYourProfile(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AboutMemberDetails(
                sub: user.learner.bio ?? (user.learner.longDescription != null ? user.learner.longDescription!
                    : user.learner.description ?? ""),
                userProfile: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SkillsMemberDetails(
                list: user.learner.skills,
                title: "Skills",
                bottomDivider: user.learner.interests.isEmpty,
                topDivider: true,
                userProfile: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SkillsMemberDetails(
                list: user.learner.interests,
                title: "Interests",
                userProfile: true,
                topDivider: user.learner.skills.isEmpty,
                bottomDivider: false,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Spotlight(
                spotlight: user.learner.spotlights.isEmpty ? null : user.learner.spotlights.first,
                visible: user.learner.spotlights.isNotEmpty,
                userProfile: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SocialMediaMembers(
                  socials: user.learner.socialMedia,
                  userProfile: true,
                  followers: int.parse((user.learner.followersCount??0).toString())),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: ProfileContactsView(contacts: user.learner.contactUsernames),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
