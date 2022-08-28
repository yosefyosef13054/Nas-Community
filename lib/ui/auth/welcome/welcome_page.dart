import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/services/exception_handler.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/auth/login/login.dart';
import 'package:nas_academy/ui/auth/register/register.dart';
import 'package:nas_academy/ui/common/logo.dart';
import 'package:nas_academy/ui/auth/welcome/fade_wrapper.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    if (mounted) {
      FlutterError.onError = (FlutterErrorDetails errorDetails) {
        ExceptionHandler.handleError(errorDetails.exception, context);
        FlutterError.presentError(errorDetails);
      };
    }
  }
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: Consumer<AuthProvider>(
        builder: (context, auth, child) {
          return Scaffold(
            primary: false,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              elevation: 0,
              primary: false,
              systemOverlayStyle: SystemUiOverlayStyle.light,
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
                  alignment: Alignment.center,
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
                    ],
                  ),
                ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Center(
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigate.push(
                                        context,
                                        ChangeNotifierProvider<
                                                AuthProvider>.value(
                                            value: auth,
                                            child: const Register()));
                                  },
                                  child: const Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    child: Text("Getting Started"),
                                  ),
                                  style: ButtonStyle(
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(48.0),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigate.push(
                                  context,
                                  ChangeNotifierProvider<AuthProvider>.value(
                                    value: auth,
                                    child: const Login(),
                                  ),
                                );
                              },
                              child: const Center(
                                  child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Already registered? ',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                        color: ColorPlate.neutral99,
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'Login',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: ColorPlate.yellow70,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 48,
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
