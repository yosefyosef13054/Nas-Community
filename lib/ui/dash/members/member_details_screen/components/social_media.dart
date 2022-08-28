import 'dart:math';

import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/user/sub/social_media.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_socials/edit_socials.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialMediaMembers extends StatefulWidget {
  const SocialMediaMembers({Key? key, required this.userProfile,required this.socials, required this.followers}) : super(key: key);
  final List<SocialMedia> socials;
  final int followers;
  final bool userProfile;

  @override
  State<SocialMediaMembers> createState() => _SocialMediaMembersState();
}

class _SocialMediaMembersState extends State<SocialMediaMembers> {
  bool _expanded = false;
  int _itemsToShow = 2;
  @override
  Widget build(BuildContext context) {
    widget.socials.removeWhere((element) => !AnyLinkPreview.isValidLink(element.link ?? ""));
    _itemsToShow = [_itemsToShow, widget.socials.length].reduce(min);
    return Visibility(
      visible: widget.socials.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Divider(
            color: ColorPlate.neutral80,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Social",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Visibility(
                visible: widget.userProfile,
                child: IconButton(
                  icon: SvgPicture.asset(Assets.edit, height: 24, width: 24,),
                  onPressed: (){
                    Navigate.push(context, const EditSocial());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
            leading: SvgPicture.asset("assets/svg/user_check.svg", height: 24, width: 24, color: ColorPlate.tertiaryLightBG,),
            title: const Text("Total Followers", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.secondaryLightBG),),
            subtitle: Text("${widget.followers}", style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            alignment: Alignment.topCenter,
            curve: Curves.fastOutSlowIn,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.socials.take(_itemsToShow).map((e) => ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                onTap: ()async{
                  await launchUrl(Uri.parse(e.link!));
                },
                trailing: SvgPicture.asset("assets/svg/external_link.svg", height: 20, width: 20, color: ColorPlate.tertiaryLightBG,),
                leading: SvgPicture.asset(e.inactiveIcon(), width: 24, height: 24),
                title: Text("${e.type}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.secondaryLightBG), ),
                subtitle: e.link != null && e.link!.isNotEmpty && _sub(e).isNotEmpty? Text(_sub(e), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16, color: Colors.black),) : null,
              )).toList(),
            ),
          ),
          Visibility(
            visible: widget.socials.length > 2,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all(ColorPlate.secondaryLightBG),
                    ),
                    icon: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      size: 18,
                    ),
                    label: Text(_expanded ? "show less" : "show more"),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                        if(_expanded){
                          _itemsToShow = widget.socials.length;
                        }else {
                          _itemsToShow = 2;
                        }
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  String _sub (SocialMedia socialMedia){
    try{
      if (socialMedia.link!.length < 10){
        return socialMedia.link!;
      }else {
        if(socialMedia.type == "facebook"){
          return "@${socialMedia.link!.substring(socialMedia.link!.lastIndexOf(".com")+5)}".replaceAll("/", "");
        }else if (socialMedia.type == "instagram"){
          String val = "@${socialMedia.link!.substring(socialMedia.link!.lastIndexOf(".com")+5)}".replaceAll("/", "");
          if(val.contains("/")){
            val = val.substring(0, val.indexOf("/")).replaceAll("/", "");
          }else if (val.contains("?")){
            val = val.substring(0, val.indexOf("?")).replaceAll("?", "");
          }
          return val;
        } else {
          return "";
        }
      }
    }catch (e){
      return "";
    }
  }
}



