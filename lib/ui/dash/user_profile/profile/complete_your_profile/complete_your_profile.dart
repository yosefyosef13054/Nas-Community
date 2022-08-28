import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_bio/edit_bio.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_contacts/edit_contacts.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_profile.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_skills_and_interests/edit_skills_and_interests.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_socials/edit_socials.dart';
import 'package:nas_academy/ui/dash/user_profile/profile/complete_your_profile/complete_profile_card.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class CompleteYourProfile extends StatelessWidget {
  const CompleteYourProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25),
      height: 350,
      width: MediaQuery.of(context).size.width,
      color: ColorPlate.neutral95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Complete your profile",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: LinearPercentIndicator(
              padding: EdgeInsets.zero,
              barRadius: const Radius.circular(170),
              backgroundColor: ColorPlate.neutral90,
              animation: true,
              lineHeight: 8,
              percent: profile.completed(user) / 5,
              animateFromLastPercent: true,
              progressColor: const Color(0xFF18AA79),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                "${profile.completed(user)} of 5 completed",
                style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: ColorPlate.tertiaryLightBG),
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
            height: 175,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                CompleteProfileCard(
                    title: "Add a bio",
                    icon: Assets.addBio,
                    done: profile.bioCompleted(user),
                    onAdd: () {
                      Navigate.push(context, const EditBio());
                    }),
                CompleteProfileCard(
                    title: "Add your skills",
                    icon: Assets.addSkills,
                    done: profile.skillsCompleted(user),
                    onAdd: () {
                      Navigate.push(context, const EditSkillsAndInterests());
                    }),
                CompleteProfileCard(
                    title: "Setup contact info",
                    icon: Assets.addContact,
                    done: profile.contactCompleted(user),
                    onAdd: () {
                      Navigate.push(context, const EditContacts());
                    }),
                CompleteProfileCard(
                    title: "Add social platforms",
                    icon: Assets.addSocials,
                    done: profile.socialMediaCompleted(user),
                    onAdd: () {
                      Navigate.push(context, const EditSocial());
                    }),
                CompleteProfileCard(
                    title: "Add profile photo",
                    icon: Assets.addPhoto,
                    done: profile.profilePhotoCompleted(user),
                    onAdd: () {
                      Navigate.push(context, EditProfileScreen(refresh: (){profile.notify();}));
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
