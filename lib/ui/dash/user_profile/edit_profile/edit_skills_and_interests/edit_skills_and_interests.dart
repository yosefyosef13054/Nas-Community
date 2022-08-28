import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/discard_changes_bottomsheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_skills_and_interests/components/add_inteerests_bottom_sheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_skills_and_interests/components/add_skills_bottom_sheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_skills_and_interests/components/list_Item.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_skills_and_interests/components/no_items_state.dart';
import 'package:provider/provider.dart';

class EditSkillsAndInterests extends StatefulWidget {
  const EditSkillsAndInterests({Key? key}) : super(key: key);

  @override
  State<EditSkillsAndInterests> createState() => _EditSkillsAndInterestsState();
}

class _EditSkillsAndInterestsState extends State<EditSkillsAndInterests> {
  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final user = Provider.of<User?>(context, listen: false);
    profile.setSkillsToShow = user?.learner.skills ?? [];
    profile.setInterestsToShow = user?.learner.interests ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    final bool valid = profile.validToUpdateSkills(user!) && !profile.loading;
    return Scaffold(
        backgroundColor: ColorPlate.neutral100,
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: 64,
          elevation: 0,
          shadowColor: ColorPlate.neutral90,
          backgroundColor: ColorPlate.neutral100,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () {
                if(valid){
                  showBarModalBottomSheet(context: context, builder: (context){
                    return const DiscardChangesDropDown();
                  });
                }else {
                  Navigator.pop(context);
                }
              },
              child:const Padding(
                padding:  EdgeInsets.only(left: 10.0),
                child:  Text(
                  'Cancel',
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
                onPressed: () async {
                  await profile.updateSkillsAndInterests(user, context);
                  Navigator.pop(context);
                  profile.notify();
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
              padding: const EdgeInsets.only(top: 16),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Skills & Interests',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: ColorPlate.primaryLightBG),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 24),
                  child: Text(
                    'Help others know what you’re good at',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPlate.secondaryLightBG),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      children: [
                        const Text(
                          'Skills',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorPlate.primaryLightBG),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const AddSkillsBottomSheet();
                                });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                          label: const Text("Add"),
                        ),
                      ],
                    )),
                profile.skillsToShow.isEmpty? NoItemsState(label: "skills", onAdd: (){
                  showBarModalBottomSheet(context: context, builder: (context){
                    return const AddSkillsBottomSheet();
                  });
                }) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        'Drag to reorder',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorPlate.secondaryLightBG),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Divider(
                        height: 20,
                        thickness: 1,
                        color: ColorPlate.neutral90,
                      ),
                    ),
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: profile.skillsToShow
                          .map((e) => DraggableItem(
                                key: Key("$e -- ${profile.skillsToShow.indexOf(e)} -- ${DateTime.now().toString()}"),
                                  label: e,
                                  onDelete: (){
                                    profile.skillsToShow.remove(e);
                                    profile.skills.removeWhere((element) => element == e);
                                    profile.deleted = true;
                                    profile.notify();
                                  },
                              ))
                          .toList(),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final String item = profile.skillsToShow.removeAt(oldIndex);
                          profile.skillsToShow.insert(newIndex, item);
                        });
                        profile.notify();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                Padding(
                    padding: const EdgeInsets.only(left: 24, right: 24),
                    child: Row(
                      children: [
                        const Text(
                          'Interests',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorPlate.primaryLightBG),
                        ),
                        const Spacer(),
                        TextButton.icon(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                          ),
                          onPressed: () {
                            showBarModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return const AddInterestsBottomSheet();
                                });
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 18,
                          ),
                          label: const Text("Add"),
                        ),
                      ],
                    )),
                profile.interestsToShow.isEmpty? NoItemsState(label: "interests", onAdd: (){
                  showBarModalBottomSheet(context: context, builder: (context){
                    return const AddInterestsBottomSheet();
                  });
                }) : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Text(
                        'Drag to reorder',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: ColorPlate.secondaryLightBG),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 24, right: 24),
                      child: Divider(
                        height: 20,
                        thickness: 1,
                        color: ColorPlate.neutral90,
                      ),
                    ),
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      children: profile.interestsToShow.map((e) =>
                          DraggableItem(
                            key: Key("$e -- ${profile.skillsToShow.indexOf(e)} -- ${DateTime.now().toString()}"),
                            label: e,
                            onDelete: (){
                              profile.interestsToShow.remove(e);
                              profile.interests.removeWhere((element) => element == e);
                              profile.deleted = true;
                              profile.notify();
                            },
                          ))
                          .toList(),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final String item = profile.interestsToShow.removeAt(oldIndex);
                          profile.interestsToShow.insert(newIndex, item);
                        });
                        profile.notify();
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
            profile.loading ? const Loading() : const SizedBox()
          ],
        ));
  }
}
