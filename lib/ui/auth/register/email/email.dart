import "package:flutter/material.dart";
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/reg_ex.dart';
import 'package:nas_academy/ui/auth/register/name/name.dart';
import 'package:provider/provider.dart';

class EmailSignupField extends StatefulWidget {
  const EmailSignupField({Key? key}) : super(key: key);

  @override
  State<EmailSignupField> createState() => _EmailSignupFieldState();
}

class _EmailSignupFieldState extends State<EmailSignupField> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late FocusNode _node;

  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _node.requestFocus();
  }


  @override
  void dispose() {
    super.dispose();
    _node.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hey ${auth.registerName}!\nWhat’s your email?',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Email',
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
              focusNode: _node,
              onChanged: (val) => auth.setRegisterEmail = val,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter your email',
              ),
              initialValue: auth.registerEmail,
              validator: (val){
                bool valid = RegEx.email.hasMatch(val!);
                if(!valid){
                  return "Please, enter a valid email";
                }else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 12,
            ),
            NextButton(
                enabled: auth.registerEmail.isNotEmpty,
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    _node.unfocus();
                    auth.registerPageController.animateToPage(
                      2,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }
}
