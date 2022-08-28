import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_contacts/components/edit_contact_screen.dart';
import 'package:provider/provider.dart';


class EditNavigationTap extends StatelessWidget {
  const EditNavigationTap({Key? key, required this.contact}) : super(key: key);
  final ContactType contact;
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final bool primary = contact.name.toLowerCase() == profile.primaryContact?.toLowerCase();
    final List<Contact> contacts = profile.contacts.where((element) => element.type == contact.name).toList();
    final Contact? con = contacts.isNotEmpty? contacts.first : null;
    final bool active = con != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    contactIcon(contact),
                    color: active? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG,
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: active? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  active? Text(
                    con.username ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.clip,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: ColorPlate.secondaryLightBG),
                  ) : const SizedBox(),
                  Visibility(
                    visible: primary,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: ColorPlate.yellow90,
                              borderRadius: BorderRadius.circular(4)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Text(
                              'Primary mode of contact',
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  color: ColorPlate.primaryLightBG),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              const Spacer(),
              active? contact == ContactType.email? const SizedBox(height: 0, width: 0,) :  TextButton(
                onPressed: (){
                  Navigate.push(context, EditContactScreen(contact: con));
                },
                child: const Text(
                  'Edit',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPlate.primaryLightBG),
                ),
              ) : TextButton(
                onPressed: (){
                  final Contact cont = Contact(type: contact.name);
                  Navigate.push(context, EditContactScreen(contact: cont));
                },
                child: const Text(
                  'Add',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPlate.primaryLightBG),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
          const Divider(
            height: 50,
            thickness: 1,
            color: ColorPlate.neutral90,
          )
        ],
      ),
    );
  }
}
