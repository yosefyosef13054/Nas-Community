import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/my_icons.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_contacts/edit_contacts.dart';
import 'package:url_launcher/url_launcher.dart';



class TelegramMemberDetails extends StatelessWidget {
  const TelegramMemberDetails({Key? key, required this.email, required this.telegramLink, required this.userProfile}) : super(key: key);
  final String? email;
  final String? telegramLink;
  final bool userProfile;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: (!userProfile && email != null && email!.isNotEmpty) || ( telegramLink!= null && telegramLink!.isNotEmpty),
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
                "Contact",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Visibility(
                visible: userProfile,
                child: IconButton(
                  icon: SvgPicture.asset(Assets.edit, height: 24, width: 24,),
                  onPressed: (){
                    Navigate.push(context, const EditContacts());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: (telegramLink!= null && telegramLink!.isNotEmpty),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onTap: ()async{
                final String? _telegram = telegramLink;
                await launchUrl(Uri.parse("https://telegram.me/$_telegram"));
              },
              leading: const Icon(MyIcons.telegram, color: ColorPlate.tertiaryLightBG, size: 24,),
              title: const Text("Reach out to me", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.tertiaryLightBG),),
              subtitle: const Text("Telegram", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
              trailing: userProfile? null : Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: ColorPlate.primaryLightBG)
                ),
                child: const Text("Reach out"),
              ),
            ),
          ),
          Visibility(
            visible: (email!= null && email!.isNotEmpty),
            child: ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              onTap: ()async{
                final String _email = "mailto:$email";
                await launchUrl(Uri.parse(_email));
              },
              leading: const Icon(Icons.email, color: ColorPlate.tertiaryLightBG, size: 24,),
              title: const Text("Reach out to me", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.tertiaryLightBG),),
              subtitle: const Text("Email", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
              trailing:userProfile? null :  Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: ColorPlate.primaryLightBG)
                ),
                child: const Text("Reach out"),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Divider(
            color: ColorPlate.neutral80,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}


