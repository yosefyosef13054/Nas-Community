import "package:flutter/material.dart";
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/reg_ex.dart';
import 'package:nas_academy/ui/auth/register/name/name.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/settings/manage_account/password/components/password_guide.dart';
import 'package:provider/provider.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({Key? key}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _node1;
  late FocusNode _node2;

  @override
  void initState() {
    super.initState();
    _node1 = FocusNode();
    _node2 = FocusNode();
    _node1.requestFocus();
  }


  @override
  void dispose() {
    super.dispose();
    _node1.dispose();
    _node2.dispose();
  }
  bool _obscure = true;
  bool _obscureTow = true;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Form(
      key: formKey,
      child: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(24.0),
            physics: const BouncingScrollPhysics(),
            children: [
              const Text(
                'Let’s setup a password',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: ColorPlate.primaryLightBG,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ColorPlate.neutral50,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                focusNode: _node1,
                textInputAction: TextInputAction.next,
                onEditingComplete: (){
                  _node1.unfocus();
                  _node2.requestFocus();
                },
                obscureText: _obscure,
                onChanged: (val)=> auth.setRegisterPass = val,
                initialValue: auth.registerPass,
                validator: (val){
                  bool valid = RegEx.pass.hasMatch(val!);
                  if(!valid){
                    return "Password must be 8+ characters, contains at least 1 lowercase, one uppercase and 1 number.";
                  }else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Enter Password',
                  hintStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffAAAAAA)),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(()=> _obscure = !_obscure);
                    },
                    icon:  Icon(_obscure
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                        color: ColorPlate.secondaryLightBG,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Re-Enter Password',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: ColorPlate.neutral50,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              TextFormField(
                focusNode: _node2,
                onChanged: (val)=> auth.setRegisterConfirmPass = val,
                initialValue: auth.registerConfirmPass,
                obscureText: _obscureTow,
                validator: (val){
                  if(val != auth.registerPass){
                    return "Passwords do not match";
                  }else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(()=> _obscureTow = !_obscureTow);
                    },
                    icon:  Icon(_obscureTow
                        ? Icons.visibility_off
                        : Icons.remove_red_eye,
                      color: ColorPlate.secondaryLightBG,

                    ),
                  ),
                  border: const OutlineInputBorder(),
                  hintText: 'Enter Password',
                  hintStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffAAAAAA),
                  ),
                ),
              ),
              const SizedBox(
                height: 36,
              ),
              const PasswordGuide(),
              const SizedBox(
                height: 24,
              ),
              NextButton(
                enabled: auth.registerPass.isNotEmpty && auth.registerConfirmPass.isNotEmpty,
                onTap: ()async{
                if(formKey.currentState!.validate()){
                  await auth.signUpWithEmailAndPassword(context);
                  auth.registerPageController.animateToPage(
                    3,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                }
              },),

            ],
          ),
          auth.loading? const Loading() : const SizedBox()
        ],
      ),
    );
  }
}
