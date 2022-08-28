import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/auth/auth.dart';
import 'package:nas_academy/core/api/auth/facebook/facebook_auth.dart';
import 'package:nas_academy/core/api/auth/google/google.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/main.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/settings/manage_account/password/change_password_screen.dart';
import 'package:nas_academy/ui/dash/settings/manage_account/password/components/change_phone_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ManageAccountScreen extends StatefulWidget {
  const ManageAccountScreen({Key? key}) : super(key: key);

  @override
  State<ManageAccountScreen> createState() => _ManageAccountScreenState();
}

class _ManageAccountScreenState extends State<ManageAccountScreen> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(24.0),
            children: [
              const Text(
                'Manage account',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                  color: ColorPlate.primaryLightBG,
                ),
              ),
              const SizedBox(
                height: 46,
              ),
              const EmailField(),
              const SizedBox(
                height: 25,
              ),
              const PhoneNumber(),
              const SizedBox(
                height: 25,
              ),
              const Password(),
              const SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 45,
                  child: OutlinedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100))),
                      foregroundColor: MaterialStateProperty.all(Colors.red[800]),
                      overlayColor:
                          MaterialStateProperty.all(Colors.red.withOpacity(0.1)),
                      side: MaterialStateProperty.all(
                          BorderSide(color: Colors.red[800]!)),
                    ),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (con) {
                            return CupertinoAlertDialog(
                              title: const Text("Confirm Delete"),
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  SizedBox(height: 15,),
                                  Text("Are you sure you want to delete your account? \n\nThis Action Can Not be Undone!",),
                                ],
                              ),
                              actions: [
                                TextButton(
                                    onPressed: ()async{
                                      Navigator.pop(con);
                                      try{
                                        setState(()=> _loading = true);
                                        await Auth().deleteAccount();
                                        final pref = await SharedPreferences.getInstance();
                                        await pref.clear();
                                        await Google.logOut();
                                        await Facebook.logOut();
                                        Restart.restartApp(context);
                                      }catch (e){
                                        setState(()=> _loading = false);
                                        rethrow;
                                      }
                                    },
                                    child: Text("Confirm Delete", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.red[700]!),)),
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Go Back",)),
                                const SizedBox(),
                              ],
                            );
                          });
                    },
                    child: const Text(
                      "Delete Account",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: ColorPlate.red40,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _loading ? const Loading() : const SizedBox(),
      ],
    );
  }
}

class EmailField extends StatelessWidget {
  const EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Email',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: ColorPlate.primaryLightBG,
          ),
        ),
        Text(
          user?.learner.email ?? user?.learner.email ?? "",
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: ColorPlate.neutral50,
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: ColorPlate.neutral90,
        ),
      ],
    );
  }
}

class PhoneNumber extends StatelessWidget {
  const PhoneNumber({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    /// don't remove : this is for listing to [notifyListeners()]
    final profile = Provider.of<ProfileProvider>(context, listen: true);
    log(profile.hashCode);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Phone number',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
                user?.learner.phoneNumber != null
                    ? Text(
                        user?.learner.phoneNumber ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: ColorPlate.neutral50,
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
            TextButton(
              child: Text(
                user?.learner.phoneNumber != null ? 'Edit' : "Add",
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: ColorPlate.primaryLightBG,
                ),
              ),
              onPressed: () {
                Navigate.push(
                  context,
                  const ChangePhoneNumberScreen(),
                );
              },
            ),
          ],
        ),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: ColorPlate.neutral90,
        ),
      ],
    );
  }
}

class Password extends StatelessWidget {
  const Password({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text(
            'Password',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          subtitle: const Text(
            '*******',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: ColorPlate.neutral50,
            ),
          ),
          trailing: TextButton(
            child: const Text(
              'Change',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            onPressed: () {
              Navigate.push(context, const ChangePasswordScreen());
            },
          ),
        ),
        const Divider(
          height: 20,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: ColorPlate.neutral90,
        )
      ],
    );
  }
}
