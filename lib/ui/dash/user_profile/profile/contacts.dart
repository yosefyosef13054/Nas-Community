import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_contacts/edit_contacts.dart';



class ProfileContactsView extends StatelessWidget {
  const ProfileContactsView({Key? key, required this.contacts}) : super(key: key);
  final List<Contact> contacts;
  @override
  Widget build(BuildContext context) {
    if(contacts.isNotEmpty){
     return Column(
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
             IconButton(
               icon: SvgPicture.asset(Assets.edit, height: 24, width: 24,),
               onPressed: (){
                 Navigate.push(context, const EditContacts());
               },
             ),
           ],
         ),
         const SizedBox(
           height: 20,
         ),
         Column(
           children: contacts.map((e) => ListTile(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
             leading: SvgPicture.asset(contactIcon(ContactType.values.where((element) => element.name == e.type).first), color: ColorPlate.tertiaryLightBG, height: 24, width: 24,),
             title: const Text("Reach out to me", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: ColorPlate.tertiaryLightBG),),
             subtitle: Text(e.type ?? "", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
           )).toList(),
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
     );
    }else {
      return const SizedBox();
    }
  }
}


