import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/discard_changes_bottomsheet.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/edit_navigationtap.dart';
import 'package:provider/provider.dart';

class EditContacts extends StatefulWidget {
  const EditContacts({Key? key}) : super(key: key);

  @override
  State<EditContacts> createState() => _EditContactsState();
}

class _EditContactsState extends State<EditContacts> {


    @override
    void initState() {
      final profile = Provider.of<ProfileProvider>(context, listen: false);
      final user = Provider.of<User?>(context, listen: false);
      if(user!.learner.contactUsernames.every((element) => element.type != ContactType.email.name)){
        user.learner.contactUsernames.add(Contact(type: ContactType.email.name, username: user.email ?? user.learner.email));
      }
      profile.contacts = user.learner.contactUsernames;
      profile.setPrimaryContactSilent = user.learner.primaryContact ?? "email";
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    final bool valid = profile.validToUpdateContacts && !profile.loading;
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
                    showBarModalBottomSheet(context: context, builder: (context){
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
                  elevation: MaterialStateProperty.all(0),
                  backgroundColor: MaterialStateProperty.all(
                      valid ? ColorPlate.yellow70 : ColorPlate.neutral90),
                  foregroundColor: MaterialStateProperty.all(
                      valid ? Colors.black : ColorPlate.tertiaryLightBG),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
                ),
                onPressed: valid ? ()async{
                 await profile.updateContacts(user!, context);
                 Navigator.pop(context);
                } : null,
                child: const Text(
                  "Save",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
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
                    'Contact info',
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
                    'Help others reach out to you',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPlate.secondaryLightBG),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                //use this
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: ContactType.values.length,
                    itemBuilder: (context, index) {
                      return EditNavigationTap(contact: ContactType.values[index],);
                    }),
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
