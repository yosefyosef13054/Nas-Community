import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/community_view/components/socail_media_button.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/members_details_screen.dart';

class FeaturedMemberCard extends StatelessWidget {
  const FeaturedMemberCard({Key? key, required this.member}) : super(key: key);
  final Member member;

  @override
  Widget build(BuildContext context) {
    member.socialMedia.removeWhere((element) => !AnyLinkPreview.isValidLink(element.link ?? ""));
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: (){
        Navigate.push(context, MemberDetailsScreen(member: member));
      },
      child: Container(
        margin: const EdgeInsets.only(right: 15),
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width - 40,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 247, 249, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${member.firstName} ${member.lastName}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: member.socialMedia.map((e) => SocialMediaButton(media: e)).toList(),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(member.learnerCountry != null? member.learnerCountry!.country! : member.country ?? "", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14, color: ColorPlate.secondaryLightBG),),
                ),
              ],
            ),
            const Spacer(),
            Align(
              alignment: Alignment.topRight,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(member.profileImage!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
