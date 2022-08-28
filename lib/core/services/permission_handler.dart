import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerService {

  Future notificationsRequest(BuildContext context) async {
    var status = await Permission.notification.status;
    if (!status.isGranted) {
      await Permission.notification.request();
      return;
    }
    if (status.isDenied || status.isPermanentlyDenied) {
      showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: const Text("Permission required"),
                content: const Text(
                    "Please go to settings and enable notification permission for Nas Academy app"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Got it"))
                ],
              ));
    }
  }

  Future<bool> notificationEnabled() async {
    var status = await Permission.notification.isGranted;
    return status;
  }

  static Future<bool> locationEnabled() async {
    var status = await Permission.location.isGranted;
    return status;
  }

  static Future<bool> locationRequest(BuildContext context) async {
    final PermissionStatus status = await Permission.location.status;
    bool granted = true;
    if (!status.isGranted) {
      final stat = await Permission.location.request();
      granted = stat.isGranted;
      if(!granted){
        showDialog(
            context: context,
            builder: (context) => CupertinoAlertDialog(
              title: const Text("Permission required"),
              content: const Text(
                  "Please go to settings and enable location permission for Nas Academy app"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                      AppSettings.openLocationSettings();
                    },
                    child: const Text("Got it"))
              ],
            ));
      }
    }
    return granted;
  }


  static Stream<bool> locationEnabledStream() async* {
    yield* Stream.periodic(
        const Duration(milliseconds: 500), (_) => locationEnabled()).asyncMap(
      (value) async => await value,
    );
  }
}
