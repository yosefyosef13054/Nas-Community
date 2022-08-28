import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/reg_ex.dart';
import 'package:nas_academy/ui/auth/login/forget_password/forget_pass.dart';
import 'package:provider/provider.dart';

class EmailLogin extends StatefulWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  State<EmailLogin> createState() => _EmailLoginState();
}

class _EmailLoginState extends State<EmailLogin> {
  late TextEditingController emailController;
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordEmailFocusNode = FocusNode();
  bool _obscure = true;

  void onInit() async {
    await Future.delayed(const Duration(milliseconds: 300));
    emailFocusNode.requestFocus();

  }

  @override
  void initState() {
    onInit();
    final auth = Provider.of<AuthProvider>(context, listen: false);
    emailController = TextEditingController(text: auth.loginEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final dash = Provider.of<DashProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0.0,
            iconTheme: const IconThemeData(color: ColorPlate.primaryLightBG),
            backgroundColor: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: IconButton(
              splashRadius: 26,
              onPressed: () async {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                  await Future.delayed(const Duration(milliseconds: 250));
                }
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 15,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 1),
              child: Visibility(
                visible: auth.loading,
                child: const LinearProgressIndicator(
                  minHeight: 1.5,
                  backgroundColor: Colors.white,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
                ),
              ),
            ),
            centerTitle: true,
            title: Text(
              'Log in',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: const Color.fromRGBO(25, 28, 30, 1)),
            ),
          ),
          body: Form(
            key: auth.formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(15.0),
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .025,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Email',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(117, 119, 122, 1)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: emailController,
                  onChanged: (val) => auth.setLoginEmail = val,
                  focusNode: emailFocusNode,
                  onEditingComplete: () {
                    emailFocusNode.unfocus();
                    passwordEmailFocusNode.requestFocus();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email is required';
                    } else if (!RegEx.email.hasMatch(value)) {
                      return "Email must be in a valid format like “name@example.com”";
                    } else {
                      return auth.error;
                    }
                  },
                  decoration: const InputDecoration(
                    hintText: "Enter your email",
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Password',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(117, 119, 122, 1)),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  onChanged: (val) => auth.setLoginPassword = val,
                  focusNode: passwordEmailFocusNode,
                  obscureText: _obscure,
                  onEditingComplete: () {
                    passwordEmailFocusNode.unfocus();
                  },
                  controller: passwordController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Password is required';
                    } else {
                      return auth.error;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "Enter Password",
                      suffixIcon: IconButton(
                        color: Colors.grey[600],
                        icon: Icon(_obscure
                            ? Icons.visibility_off
                            : Icons.remove_red_eye),
                        onPressed: () => setState(() => _obscure = !_obscure),
                      )),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPassWebView()),
                      );
                    },
                    child: Text(
                      'Forgot your password?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          decoration: TextDecoration.underline,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromRGBO(117, 119, 122, 1)),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                  ),
                  child: SizedBox(
                    height: 48,
                    width: MediaQuery.of(context).size.width - 32,
                    child: ElevatedButton(
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      onPressed: () async {
                        await auth.loginWithEmailAndPassword(context, dash);
                        dash.init();
                      },
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
