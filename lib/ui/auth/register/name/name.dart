import "package:flutter/material.dart";
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/auth/login/components/icon_container.dart';
import 'package:provider/provider.dart';

class NameField extends StatefulWidget {
  const NameField({Key? key}) : super(key: key);

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
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
    final dash = Provider.of<DashProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            'What’s your name?',
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
            'Name',
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
            onChanged: (val) => auth.setRegisterName = val,
            initialValue: auth.registerName,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter your name',
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          NextButton(
              enabled: auth.registerName.length > 2,
              onTap: () {
                _node.unfocus();
                auth.registerPageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeInOut,
                );
              }),
        ],
      ),
      bottomNavigationBar:
          KeyboardVisibilityBuilder(builder: (context, visible) {
        return Visibility(
          visible: !visible,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .4,
                      color: const Color.fromRGBO(170, 171, 174, 1),
                    ),
                    Text(
                      'OR',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: const Color.fromRGBO(170, 171, 174, 1),
                      ),
                    ),
                    Container(
                      height: 1,
                      width: MediaQuery.of(context).size.width * .4,
                      color: const Color.fromRGBO(170, 171, 174, 1),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                IconContainer(
                  onTap: () async {
                    await auth.socialLogin(context, AuthType.apple, dash);
                  },
                  image: "assets/svg/apple.svg",
                  imageColor: Colors.black,
                  text: "Continue with Apple",
                  theme: Brightness.light,
                ),
                const SizedBox(
                  height: 16,
                ),
                IconContainer(
                  onTap: () async {
                    // Navigate.push(context,  InAppPurchaseScreen());
                    await auth.socialLogin(context, AuthType.facebook, dash);
                  },
                  image: "assets/svg/Facebook Logo.svg",
                  text: "Continue with Facebook",
                  theme: Brightness.light,
                ),
                const SizedBox(
                  height: 16,
                ),
                IconContainer(
                  onTap: () async {
                    await auth.socialLogin(context, AuthType.google, dash);
                  },
                  image: "assets/svg/Google Logo.svg",
                  text: "Continue with Google",
                  theme: Brightness.light,
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class NextButton extends StatelessWidget {
  const NextButton({Key? key, required this.enabled, required this.onTap})
      : super(key: key);
  final Function onTap;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ClipOval(
        child: Material(
          color: enabled ? ColorPlate.yellow70 : ColorPlate.neutral90,
          child: InkWell(
            splashColor: ColorPlate.yellow90, // Splash color
            onTap: enabled
                ? () {
                    onTap();
                  }
                : null,
            child: SizedBox(
              width: 56,
              height: 56,
              child: Icon(
                Icons.arrow_forward,
                color: enabled ? Colors.black : ColorPlate.tertiaryLightBG,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
