import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/extensions.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/discard_changes_bottomsheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_socials/components/no_social_media_state.dart';
import 'package:provider/provider.dart';
import 'components/edit_dragable_item.dart';
import 'components/social_bottom_sheet.dart';

class EditSocial extends StatefulWidget {
  const EditSocial({Key? key}) : super(key: key);

  @override
  State<EditSocial> createState() => _EditSocialState();
}

class _EditSocialState extends State<EditSocial> {
  late TextEditingController _textEditingController;

    @override
    void initState() {
      final user = Provider.of<User?>(context, listen: false);
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      profile.socials = user!.learner.socialMedia;
      _textEditingController = TextEditingController(text: user.learner.followersCount?.thousandFormat);
      super.initState();
    }



      @override
      void dispose() {
        super.dispose();
        _textEditingController.dispose();
    }
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final profile = Provider.of<ProfileProvider>(context);
    final bool valid = profile.validToUpdateSocials(user!) && !profile.loading;
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
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: InkWell(
                onTap: () {
                 if(valid){
                   showBarModalBottomSheet(context: context, builder:(context){
                     return const DiscardChangesDropDown();
                   });
                 }else {
                   Navigator.pop(context);
                 }
                },
                child: const Text(
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
                onPressed: !valid? null : () async {
                  await profile.updateSocialMedia(user, context);
                  profile.notify();
                  Navigator.pop(context);
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
                const Text(
                  'Social',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: ColorPlate.primaryLightBG),
                ),
                const SizedBox(
                  height: 12,
                ),
                const Text(
                  'Help others find you on social platforms',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPlate.secondaryLightBG),
                ),
                const SizedBox(
                  height: 35,
                ),
                TextFormField(
                  controller: _textEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (val){
                    if(val.isNotEmpty){
                      profile.setTotalFollowers = val.replaceAll(",", "");
                      profile.setUpdateSocials = true;
                      val = int.parse(val).thousandFormat;
                      _textEditingController.value = TextEditingValue(
                        text: val,
                        selection: TextSelection.collapsed(offset: val.length),
                      );
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Total number of followers'
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                profile.socials.isEmpty? const NoSocialMediaState() : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Drag to reorder',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: ColorPlate.secondaryLightBG),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 1,
                      color: ColorPlate.neutral90,
                    ),
                    ReorderableListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: profile.socials.map((e) =>
                          EditSocialItem(
                            key: Key("${e.type!} ${e.link}-${profile.socials.indexOf(e)}"),
                            media: e,
                          )
                      ).toList(),
                      onReorder: (int oldIndex, int newIndex) {
                        setState(() {
                          if (oldIndex < newIndex) {
                            newIndex -= 1;
                          }
                          final SocialMedia item = profile.socials.removeAt(oldIndex);
                          profile.socials.insert(newIndex, item);
                        });
                        profile.notify();

                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: OutlinedButton.icon(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                      foregroundColor: MaterialStateProperty.all(Colors.black),
                      side: MaterialStateProperty.all(const BorderSide(color: ColorPlate.secondaryLightBG))
                    ),
                      onPressed: () {
                        showBarModalBottomSheet(context: context, builder: (context){
                          return const SocialBottomSheet();
                        });
                      },
                      icon: const Icon(Icons.add, size: 18,),
                      label: const Text(
                        'Add',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: ColorPlate.primaryLightBG),
                      ),
                      ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
            profile.loading? const Loading() : const SizedBox()
          ],
        ));
  }
}
