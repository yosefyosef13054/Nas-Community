import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/discard_changes_bottomsheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/main_dropdown.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/main_navigatetap.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/pick_profile_image_bottom_sheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_contacts/edit_contacts.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_socials/edit_socials.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/edit_spotlight.dart';
import 'package:provider/provider.dart';
import 'edit_bio/edit_bio.dart';
import 'edit_skills_and_interests/edit_skills_and_interests.dart';


class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({Key? key, required this.refresh}) : super(key: key);
  final Function refresh;
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    final valid = profile.validToSaveGeneralInfo(user) && !profile.loading;
    return Scaffold(
        backgroundColor: ColorPlate.neutral100,
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: 64,
          elevation: 0,
          shadowColor: ColorPlate.neutral90,
          backgroundColor: ColorPlate.neutral100,
          centerTitle: true,
          title: const Text(
            'Edit profile',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorPlate.primaryLightBG),
          ),
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () {
                  if(valid){
                    showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      duration: const Duration(milliseconds: 300),
                      animationCurve: Curves.easeInOut,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) {
                        return const DiscardChangesDropDown();
                      },
                    );
                  }else {
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: ColorPlate.primaryLightBG),
                ),
              ),
            ),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        valid ? ColorPlate.yellow70 : Colors.grey),
                    foregroundColor: MaterialStateProperty.all(
                        valid ? Colors.black : Colors.white),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100))),
                    elevation: MaterialStateProperty.all(0)),
                onPressed: () async{
                  if(user != null){
                    await profile.editGeneralProfile(user, context).catchError((error){
                      profile.setLoading = false;
                    });
                    widget.refresh();
                    profile.notify();
                  }
                },
                child: const Text("Save"),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(25),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: profile.profilePhoto != null ? Image.file(File(profile.profilePhoto!.path), fit: BoxFit.cover, height: 120, width: 120,) : Image.network(user!.learner.profileImage!, fit: BoxFit.cover, height: 120, width: 120,),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: TextButton(
                    onPressed: ()async{
                     showBarModalBottomSheet(context: context, builder: (context){
                       return const PickProfileImageBottomSheet();
                     });
                    },
                    child: const Text(
                      'Change profile photo',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorPlate.primaryLightBG),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                TextFormField(
                  initialValue: profile.name ?? "${user!.learner.firstName ?? ""} ${user.learner.lastName ?? ""}",
                  onChanged: (val)=> profile.setName = val,
                  decoration: const InputDecoration(
                    label: Text(
                      "Name",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: ColorPlate.primaryLightBG),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const CountryPicker(),
                const SizedBox(
                  height: 48,
                ),
                MainNavigateTap(
                  title: 'Bio',
                  onTap: ()=>Navigate.push(context, const EditBio()),
                  desc: user?.learner.bio != null && user!.learner.bio!.isNotEmpty ? user.learner.bio! :'For Eg: Hi! I’m an avid photographer for over 8 years. I have travelled around the world in search of wonderful stories to tell through the moments and memories that I capture',
                ),
                MainNavigateTap(
                  onTap: ()=>Navigate.push(context, const EditContacts()),
                  title: 'Contact',
                  desc: 'Help others reach out to you',
                ),
                MainNavigateTap(
                  onTap: ()=>Navigate.push(context, const EditSkillsAndInterests()),
                  title: 'Skills & Interests',
                  desc:
                      'Help others know what you’re good at to connect and grow together',
                ),
                MainNavigateTap(
                  onTap: ()=>Navigate.push(context, const EditSpotlight()),
                  title: 'Spotlight',
                  desc: 'Feature your best work, portfolio, or anything you like',
                ),
                MainNavigateTap(
                  onTap: ()=>Navigate.push(context, const EditSocial()),
                  title: 'Social',
                  desc: 'Help others find you on social platforms',
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
            profile.loading? const Loading() : const SizedBox(),
          ],
        ));
  }
}
