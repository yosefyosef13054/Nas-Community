import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/auth/auth.dart';
import 'package:nas_academy/core/services/launcher.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/settings/components/setting_tile_card.dart';
import 'package:nas_academy/ui/dash/settings/give_us_feeback/give_us_feeback.dart';
import 'package:nas_academy/ui/dash/settings/help_desk/help_desk.dart';
import 'package:nas_academy/ui/dash/settings/manage_account/manage_account.dart';
import 'package:nas_academy/ui/dash/settings/notifications/notifications_settings_screen.dart';
import 'package:nas_academy/ui/dash/settings/privacy_policy/privacy_policy.dart';
import 'package:nas_academy/ui/dash/settings/terms_of_service/terms_of_service.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: ColorPlate.primaryLightBG,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Account',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SettingTileCard(
            icon: Assets.profile,
            onTap: () {
              Navigate.push(context, const ManageAccountScreen());
            },
            text: 'Manage account',
          ),
          SettingTileCard(
            icon: Assets.bell,
            onTap: () {
              Navigate.push(context, const NotificationsSettingsScreen());
            },
            text: 'Notifications',
          ),
          SettingTileCard(
            icon: Assets.payments,
            onTap: ()async{
              await Launcher.launchSubscriptionsPage();
              // Navigate.push(context, const MembershipBillingScreen());
            },
            text: 'Membership & Billing',
          ),
          const SizedBox(
            height: 28,
          ),
          const Text(
            'Support',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SettingTileCard(
            icon: Assets.supportAgent,
            onTap: () {
              Navigate.push(context, const HelpDeskScreen());
            },
            text: 'Help desk',
          ),
          SettingTileCard(
            icon: Assets.rateReview,
            onTap: () {
              Navigate.push(context, const GiveUsFeedbackWebView());
            },
            text: 'Give us feedback',
          ),
          const SizedBox(
            height: 28,
          ),
          const Text(
            'Legal',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          const SizedBox(
            height: 18,
          ),
          SettingTileCard(
            icon: Assets.policy,
            onTap: () {
              Navigate.push(context, const TermsOfServiceWebView());
            },
            text: 'Terms of Service',
          ),
          SettingTileCard(
            icon: Assets.policy,
            onTap: () {
              Navigate.push(context, const PrivacyPolicyWebView());
            },
            text: 'Privacy policy',
          ),
          const SizedBox(
            height: 38,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              height: 45,
              child: OutlinedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                  foregroundColor: MaterialStateProperty.all(Colors.red[800]),
                  side: MaterialStateProperty.all( BorderSide(color: Colors.red[800]!))
                ),
                onPressed: () async {
                  await Auth().logOut(context);
                },
                child: const Text(
                  "Log out",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: ColorPlate.red40,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 54,
          ),
        ],
      ),
    );
  }
}
