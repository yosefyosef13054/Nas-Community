import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/auth_provier/auth_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/auth/register/email/email.dart';
import 'package:nas_academy/ui/auth/register/magic_link/magic_link.dart';
import 'package:nas_academy/ui/auth/register/name/name.dart';
import 'package:nas_academy/ui/auth/register/password/password.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late AuthProvider _authProvider;

  @override
  void initState() {
    super.initState();
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
    _authProvider.setRegisterPageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _authProvider.registerPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
          onPressed: (){
            if(_authProvider.registerIndex == 0){
              Navigator.pop(context);
            }else {
              _authProvider.registerPageController.animateToPage(_authProvider.registerIndex - 1, duration: const Duration(milliseconds: 250), curve: Curves.ease);
            }
            _authProvider.setLoading = false;
          },
        ),
        title: const Text(
          "Get Started",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child: Visibility(
            visible: _authProvider.loading,
            child: const LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.transparent,
              valueColor:
              AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          ),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _authProvider.registerPageController,
        onPageChanged: (index) => _authProvider.setRegisterIndex = index,
        children: const [
          NameField(),
          EmailSignupField(),
          PasswordField(),
          MagicLink(),
        ],
      ),
    );
  }
}
