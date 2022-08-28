import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/edit_profile/edit_profile.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/messenger.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/new_spotlight_preview.dart';
import 'package:provider/provider.dart';

class AddNewSpotlight extends StatefulWidget {
  const AddNewSpotlight({Key? key}) : super(key: key);

  @override
  State<AddNewSpotlight> createState() => _AddNewSpotlightState();
}

class _AddNewSpotlightState extends State<AddNewSpotlight> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final profile = Provider.of<ProfileProvider>(context, listen: false);
    _controller = TextEditingController(text: profile.spotlightLink);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    final valid = profile.validLink() && !profile.loading;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          title: const Text(
            "Add spotlight",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
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
                    SpotLight spotlight = SpotLight(
                        link: profile.spotlightLink
                    );
                    user.learner.spotlights.add(spotlight);
                    profile.notify();

                    try{
                      profile.setLoading = true;
                      await const EditProfile().updateSpotlights(user.learner.spotlights);
                      Messenger.showSuccessSnackBar(context);
                      profile.setLoading = false;
                    }catch (e){
                      profile.setLoading = false;
                      rethrow;
                    }
                    Navigator.pop(context);
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
              children: [
                const SizedBox(
                  height: 20,
                ),
                Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    TextFormField(
                      controller: _controller,
                      onChanged: (val) => profile.setSpotlightLink = val,
                      decoration: const InputDecoration(
                        labelText: "link",
                        contentPadding:
                            EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 50),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorPlate.secondaryLightBG)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: ColorPlate.secondaryLightBG)),
                      ),
                    ),
                    IconButton(
                        highlightColor: Colors.red.withOpacity(0.1),
                        splashColor: Colors.red.withOpacity(0.1),
                        splashRadius: 20,
                        onPressed: () {
                          _controller.clear();
                          profile.setSpotlightLink = "";
                          FocusScope.of(context).unfocus();
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 18,
                        )),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const NewSpotlightPreview(),
              ],
            ),
            profile.loading ? const Loading() : const SizedBox()
          ],
        ),
      ),
    );
  }
}
