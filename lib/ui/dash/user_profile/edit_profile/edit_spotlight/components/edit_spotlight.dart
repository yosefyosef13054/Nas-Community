import 'dart:io';

import 'package:any_link_preview/any_link_preview.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/components/pick_images_bottom_sheet.dart';
import 'package:provider/provider.dart';

class EditSpotLightFields extends StatefulWidget {
  const EditSpotLightFields(
      {Key? key, required this.spotlight, required this.data})
      : super(key: key);
  final SpotLight spotlight;
  final Metadata? data;

  @override
  State<EditSpotLightFields> createState() => _EditSpotLightFieldsState();
}

class _EditSpotLightFieldsState extends State<EditSpotLightFields> {
  late ProfileProvider _profileProvider;

  @override
  void initState() {
    super.initState();
    _profileProvider = Provider.of<ProfileProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _profileProvider.dis();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final bool valid = profile.validToSaveSpotlight(widget.spotlight, widget.data) && !profile.loading;
    final user = Provider.of<User?>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          centerTitle: true,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Edit Spotlight",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
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
                  await profile.editSpotlight(widget.spotlight, widget.data, user, context);
                  profile.notify();
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
              padding: const EdgeInsets.all(25),
              physics: const BouncingScrollPhysics(),
              children: [
                TextFormField(
                  onChanged: (val) => profile.setSpotLightTitle = val,
                  initialValue: widget.spotlight.title ?? widget.data?.title,
                  decoration: const InputDecoration(
                    labelText: "Title *",
                    contentPadding:
                        EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 50),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPlate.secondaryLightBG)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPlate.secondaryLightBG)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                TextFormField(
                  maxLines: 5,
                  onChanged: (val) => profile.setSpotLightDes = val,
                  initialValue: widget.spotlight.description ?? widget.data?.desc,
                  decoration: const InputDecoration(
                    labelText: "Description",
                    contentPadding: EdgeInsets.all(25),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPlate.secondaryLightBG)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorPlate.secondaryLightBG)),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: profile.spotLightImage != null
                        ? Image.file(File(profile.spotLightImage!.path))
                        : widget.spotlight.thumbnail != null || widget.data?.image != null ?  Image.network(widget.spotlight.thumbnail ?? widget.data!.image!) : const SizedBox(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    height: 30,
                    child: OutlinedButton.icon(
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100))),
                            side: MaterialStateProperty.all(const BorderSide(
                                color: ColorPlate.secondaryLightBG))),
                        onPressed: () {
                          showBarModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return ChangeNotifierProvider<
                                        ProfileProvider>.value(
                                    value: profile,
                                    child: const PickImageBottomSheet());
                              });
                        },
                        icon: SvgPicture.asset(
                          Assets.edit,
                          height: 18,
                          width: 18,
                          color: Colors.black,
                        ),
                        label: const Text("Change image")),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
            profile.loading? const Loading() : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
