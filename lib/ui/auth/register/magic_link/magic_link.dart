import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/auth/login/email_login/email_login.dart';
import 'package:provider/provider.dart';

class MagicLink extends StatelessWidget {
  const MagicLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Let’s verify your email',
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
            'We have sent a magic link to your email. Click on the link to verify your email.',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorPlate.neutral50,
            ),
          ),
          const SizedBox(
            height: 75,
          ),
          Center(child: SvgPicture.asset(Assets.mailOpen)),
          const SizedBox(
            height: 100,
          ),
          Center(
            child: SizedBox(
              height: 40,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
                  elevation: MaterialStateProperty.all(0),
                ),
                child: const Text("Login"),
                onPressed: (){
                  auth.setLoginEmail = auth.registerEmail;
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigate.push(context, ChangeNotifierProvider<AuthProvider>.value(
                      value: auth,
                      child: const EmailLogin()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
