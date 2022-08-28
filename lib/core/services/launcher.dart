import 'dart:io';

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/modules/community/subs/platform.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/ui/common/my_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class Launcher {
  Launcher._();


  static Future launchEmail (String email)async{
    final String _email = "mailto:$email?";
    await launchUrl(Uri.parse(_email));
  }


  static IconData platformIcon (MediaPlatform platform){
    switch (platform.name){
      case "telegram": return MyIcons.telegram;
      case "discord": return LineIcons.discord;
      case "whatsapp": return LineIcons.whatSApp;
      default : return Icons.error_outline_outlined;
    }
  }

  static Future launch (MediaPlatform platform)async{
    switch (platform.name){
      case "telegram": await _launchTelegram(platform.link);
      break;
      case "discord": await _launchDiscord(platform.link);
      break;
      case "whatsapp": _launchWhatsapp(platform.link);
      break;
      }
  }


  static Future _launchTelegram (String? link) async{
    if(link != null && link.isNotEmpty){
      await launchUrl(Uri.parse(link));
    }else {
      /// TODO change the error type
      throw ServerError(
        title: "Failed to open Telegram",
        body: "Link is invalid"
      );
    }
  }

  static Future _launchWhatsapp (String? link)async{
    if(link != null && link.isNotEmpty){
      await launchUrl(Uri.parse(link));
    }else {
      /// TODO change the error type
      throw ServerError(
          title: "Failed to open Whatsapp",
          body: "Whatsapp number is invalid"
      );
    }
  }



  static Future _launchDiscord (String? link)async{
    if(link != null && link.isNotEmpty){
      await launchUrl(Uri.parse(link));
    }else {
      /// TODO change the error type
      throw ServerError(
          title: "Failed to open Discord",
          body: "Discord account is invalid"
      );
    }
  }


  static Future launchSubscriptionsPage ()async{
    if(Platform.isIOS){
      await launchUrl(Uri.parse("https://apps.apple.com/account/subscriptions"));
    }else if (Platform.isAndroid){
      await launchUrl(Uri.parse("https://play.google.com/store/account/subscriptions?sku=pro.monthly.testsku&package=com.nas.academy"));
    }
  }
}