import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/sub/contact.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/delete_bottomsheet.dart';
import 'package:provider/provider.dart';

class EditContactScreen extends StatefulWidget {
  const EditContactScreen({
    Key? key,
    required this.contact
  }) : super(key: key);

  final Contact contact;
  @override
  State<EditContactScreen> createState() => _EditContactScreenState();
}

class _EditContactScreenState extends State<EditContactScreen> {
  String? _newUsername;
  bool _valid = false;
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final bool valid = (_newUsername != null && _newUsername!.isNotEmpty && _newUsername != widget.contact.username) || _valid;
    final bool primary = widget.contact.type!.toLowerCase() == profile.primaryContact?.toLowerCase();
    return Scaffold(
        backgroundColor: ColorPlate.neutral100,
        appBar: AppBar(
          leadingWidth: 80,
          toolbarHeight: 64,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.contact.type?? "",
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: ColorPlate.primaryLightBG),
          ),
          foregroundColor: Colors.black,
          shadowColor: ColorPlate.neutral90,
          backgroundColor: ColorPlate.neutral100,
          leading: IconButton(
            icon: const Icon(Icons.close, size: 19,),
            onPressed: ()=> Navigator.pop(context),
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
                  if(primary){
                    profile.setPrimaryContact = widget.contact.type;
                  }
                  if(_newUsername != null && _newUsername!.isNotEmpty && _newUsername != widget.contact.username){
                    widget.contact.username = _newUsername;
                    profile.contacts.removeWhere((element) => element.type == widget.contact.type);
                    profile.contacts.add(widget.contact);
                  }

                  profile.setValidToUpdateContacts = true;
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
        body: ListView(
          padding: const EdgeInsets.all(25),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          children: [
            TextFormField(
              initialValue: widget.contact.username,
              onChanged: (val)=> setState(()=> _newUsername = val),
              decoration: InputDecoration(
                labelText: widget.contact.type
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'Set as primary mode of contact',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorPlate.secondaryDarkBG),
              ),
              leading: Checkbox(
                fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
                checkColor: Colors.white,
                value: primary,
                onChanged: (bool? value) {
                  if(primary){
                    setState((){profile.setPrimaryContact = "email";});
                  }else {
                    setState((){profile.setPrimaryContact = widget.contact.type;});
                  }
                  _valid = true;
                  profile.notify();
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Visibility(
              visible: widget.contact.username != null && widget.contact.username!.isNotEmpty,
              child: Align(
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
                          profile.contacts.remove(widget.contact);
                          if(primary){
                            profile.setPrimaryContact = null;
                          }
                          profile.setValidToUpdateContacts = true;
                          _valid = true;
                          profile.notify();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                      );
                    });
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
