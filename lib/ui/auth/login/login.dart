import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/auth/login/components/icon_container.dart';
import 'package:nas_academy/ui/auth/login/email_login/email_login.dart';
import 'package:nas_academy/ui/auth/register/register.dart';
import 'package:nas_academy/ui/common/logo.dart';
import 'package:nas_academy/ui/auth/welcome/fade_wrapper.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child: Visibility(
            visible: auth.loading,
            child: const LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/Blur.png",
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(15.0),
              children: [
                Hero(
                    tag: 'logo',
                    child: GestureDetector(
                        onTap: () async {
                          // await Auth().createCategory();
                        },
                        child: const Logo(width: 56, height: 56))),
                const SizedBox(
                  height: 13,
                ),
                Fade(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .69,
                    child: Center(
                      child: Text(
                        'The right community can change your life',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                            color: ColorPlate.primaryDarkBG),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                ),
                Fade(
                  child: IconContainer(
                      onTap: () async {
                        await auth.socialLogin(context, AuthType.apple, dash);
                      },
                      image: "assets/svg/apple.svg",
                      text: "Continue with Apple",),
                ),
                const SizedBox(
                  height: 16,
                ),
                Fade(
                  child: IconContainer(
                      onTap: () async {
                        // Navigate.push(context,  InAppPurchaseScreen());
                        await auth.socialLogin(
                            context, AuthType.facebook, dash);
                      },
                      image: "assets/svg/Facebook Logo.svg",
                      text: "Continue with Facebook"),
                ),
                const SizedBox(
                  height: 16,
                ),
                Fade(
                  child: IconContainer(
                      onTap: () async {
                        await auth.socialLogin(context, AuthType.google, dash);
                      },
                      image: "assets/svg/Google Logo.svg",
                      text: "Continue with Google"),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Fade(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          height: 1,
                          width: MediaQuery.of(context).size.width * .4,
                          color: const Color.fromRGBO(170, 171, 174, 1)),
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
                          color: const Color.fromRGBO(170, 171, 174, 1)),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .03,
                ),
                Fade(
                  child: IconContainer(
                      onTap: () {
                        Navigate.push(
                            context,
                            ChangeNotifierProvider<AuthProvider>.value(
                                value: auth, child: const EmailLogin()),
                            offset: const Offset(-1, 0));
                      },
                      image: "assets/svg/email.svg",
                      text: "Log in with email"),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigate.push(
                        context,
                        ChangeNotifierProvider<AuthProvider>.value(
                            value: auth, child: const Register()));
                  },
                  child: const Center(
                      child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Don’t have an account? ',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorPlate.neutral99,
                          ),
                        ),
                        TextSpan(
                          text: 'Get Started',
                          style: TextStyle(
                            color: ColorPlate.yellow70,
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
