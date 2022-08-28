import 'package:flutter/material.dart';
import 'package:nas_academy/core/api/edit_profile/edit_profile.dart';
import 'package:nas_academy/core/services/messenger.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/reg_ex.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/settings/manage_account/password/components/password_guide.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureNewConfirm = true;
  String _oldPass = "";
  String _newPass = "";
  String _newPassConfrim = "";
  bool _loading = false;
  @override
  Widget build(BuildContext context) {
    final bool valid = _oldPass.isNotEmpty && _newPass.isNotEmpty && _newPassConfrim.isNotEmpty && !_loading;
    return Scaffold(
      backgroundColor: ColorPlate.neutral100,
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: 64,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Change password',
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 60),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
              backgroundColor: MaterialStateProperty.all(valid? ColorPlate.yellow70 : ColorPlate.neutral90),
              foregroundColor: MaterialStateProperty.all(valid? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),

            ),
            child: const Text(
              'Save password',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            onPressed: valid ? ()async{
              if(formKey.currentState!.validate()){
                try{
                  setState(()=> _loading = true);
                  await const EditProfile().editPassword(old: _oldPass, newPass: _newPass, newPassConfirm: _newPassConfrim);
                  setState(()=> _loading = false);
                  Messenger.showSuccessSnackBar(context);
                  Navigator.pop(context);
                }catch (e){
                  setState(()=> _loading = false);
                  rethrow;
                }
              }
            } : null,
          ),
        ),
      ),
      body: Stack(
        children: [
          Form(
            key: formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(25),
              shrinkWrap: true,
              children: [
                TextFormField(
                  onEditingComplete: ()=> FocusScope.of(context).nextFocus(),
                  obscureText: _obscureNew,
                  onChanged: (val)=> setState(()=>  _oldPass = val),
                  validator: (val)=> val == null || val.isEmpty? "Enter your old password" : null,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPlate.primaryLightBG,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(()=> _obscureOld = !_obscureOld);
                      },
                      icon:  Icon(_obscureOld
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                        color: ColorPlate.secondaryLightBG,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  onEditingComplete: ()=> FocusScope.of(context).nextFocus(),
                  obscureText: _obscureNew,
                  onChanged: (val)=> setState(()=>  _newPass = val),
                  validator: (val){
                    bool valid = RegEx.pass.hasMatch(val!);
                    if(!valid){
                      return "Password must be 8+ characters, contains at least 1 lowercase, one uppercase and 1 number.";
                    }else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    labelStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      color: ColorPlate.primaryLightBG,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(()=> _obscureNew = !_obscureNew);
                      },
                      icon:  Icon(_obscureNew
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                        color: ColorPlate.secondaryLightBG,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 30,),
                TextFormField(
                  onChanged: (val)=> setState(()=>  _newPassConfrim = val),
                  obscureText: _obscureNewConfirm,
                  validator: (val){
                    if(val != _newPass){
                      return "Passwords do not match";
                    }else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(()=> _obscureNewConfirm = !_obscureNewConfirm);
                      },
                      icon:  Icon(_obscureNewConfirm
                          ? Icons.visibility_off
                          : Icons.remove_red_eye,
                        color: ColorPlate.secondaryLightBG,

                      ),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPlate.primaryLightBG,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: PasswordGuide(),)
              ],
            ),
          ),
          _loading? const Loading() : const SizedBox()
        ],
      ),
    );
  }
}
