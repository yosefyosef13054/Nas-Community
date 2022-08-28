import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:provider/provider.dart';

class EditBio extends StatefulWidget {
  const EditBio({Key? key}) : super(key: key);

  @override
  State<EditBio> createState() => _EditBioState();
}

class _EditBioState extends State<EditBio> {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    final bool valid = profile.validToUpdateBio(user) && !profile.loading;
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
                  Navigator.pop(context);
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
                onPressed: () async{
                  await profile.editBio(user, context);
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
                    'Bio',
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
                    'Help others get to know you more',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPlate.secondaryLightBG),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: TextFormField(
                    initialValue: profile.bio ?? user?.learner.bio,
                    onChanged: (val)=> profile.setBio = val,
                    maxLines: 8,
                    maxLength: 800,
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      border: OutlineInputBorder(),
                    ),
                  ),
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
