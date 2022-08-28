import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';
import '../../components/delete_bottomsheet.dart';

class EditSocialMediaScreen extends StatefulWidget {
  const EditSocialMediaScreen({
    Key? key,
    required this.media
  }) : super(key: key);
  final SocialMedia media;

  @override
  State<EditSocialMediaScreen> createState() => _EditSocialMediaScreenState();
}

class _EditSocialMediaScreenState extends State<EditSocialMediaScreen> {
  String _link = "";
  @override
  Widget build(BuildContext context) {
   final profile = Provider.of<ProfileProvider>(context);
   final user = Provider.of<User?>(context);
    final bool valid = _link.isNotEmpty && _link != widget.media.link && AnyLinkPreview.isValidLink(_link);
    return Scaffold(
        backgroundColor: ColorPlate.neutral100,
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: 64,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Edit social platform',
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
                  profile.socials.removeWhere((element) => element.link == widget.media.link);
                  widget.media.link = _link;
                  profile.socials.add(widget.media);
                  profile.setUpdateSocials = true;
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
                  widget.media.activeIcon(),
                  width: 21,
                  height: 28,
                ),
                const SizedBox(
                  width: 18,
                ),
                Text(
                  widget.media.type!,
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
              initialValue: widget.media.link,
              onChanged: (val)=> setState(()=> _link = val),
              decoration: const InputDecoration(
                  labelText: 'Link to your social platform'
              ),
            ),

            const SizedBox(
              height: 40,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: OutlinedButton.icon(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all(Colors.black),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                    side: MaterialStateProperty.all(const BorderSide(color: ColorPlate.secondaryLightBG))
                ),
                icon: SvgPicture.asset(Assets.delete, height: 18, width: 18,),
                label: const Text(
                  'Delete',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorPlate.primaryLightBG),
                ),
                onPressed: (){
                  showBarModalBottomSheet(context: context, builder: (context){
                    return DeleteBottomSheet(
                      onDelete: (){
                        profile.socials.removeWhere((element) => element.link == widget.media.link && element.type == widget.media.type);
                       user!.learner.socialMedia.removeWhere((element) => element.link == widget.media.link && element.type == widget.media.type);
                        profile.setUpdateSocials = true;
                        profile.notify();
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    );
                  });
                },
              ),
            ),
          ],
        ));
  }
}
