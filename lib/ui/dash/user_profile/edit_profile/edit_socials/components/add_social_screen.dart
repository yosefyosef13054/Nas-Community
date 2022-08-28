import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:provider/provider.dart';

class AddUpdateSocial extends StatefulWidget {
  const AddUpdateSocial({
    Key? key,
    required this.type
  }) : super(key: key);
  final SocialMediaTypes type;

  @override
  State<AddUpdateSocial> createState() => _AddUpdateSocialState();
}

class _AddUpdateSocialState extends State<AddUpdateSocial> {
  String _link = "";
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final bool valid = _link.isNotEmpty && AnyLinkPreview.isValidLink(_link);
    return Scaffold(
        backgroundColor: ColorPlate.neutral100,
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: 64,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add social platform',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorPlate.primaryLightBG),
          ),
          shadowColor: ColorPlate.neutral90,
          backgroundColor: ColorPlate.neutral100,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.close,
                    color: ColorPlate.primaryLightBG,
                  )),
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
                  SocialMedia media = SocialMedia(
                    link: _link,
                    type: widget.type.name.toLowerCase()
                  );
                  if(!profile.socials.any((element) => element.type!.toLowerCase() == widget.type.name.toLowerCase())){
                    profile.socials.add(media);
                    profile.notify();
                    profile.setUpdateSocials = true;
                    Navigator.pop(context);
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
        body: ListView(
          padding: const EdgeInsets.all(25),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 26,
                ),
                SvgPicture.asset(
                  socialMediaActiveIcon(widget.type),
                  width: 21,
                  height: 28,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  socialMediaTypesToString(widget.type),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: ColorPlate.primaryLightBG),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            TextFormField(
              onChanged: (val)=> setState(()=> _link = val),
              decoration: const InputDecoration(
                  labelText: 'Link to your social platform'
              ),
            ),
          ],
        ));
  }
}
