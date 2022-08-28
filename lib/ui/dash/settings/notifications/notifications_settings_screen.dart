import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/notification/notifications_api.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/notification/notifications_pref.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/settings/notifications/components/notifications_tile.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {

  late Future<NotificationPreference> future;

    @override
    void initState() {
      super.initState();
      future = UserLocalDB.getNotificationPreference();
    }
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
      ),
      body: FutureBuilder<NotificationPreference>(
          initialData: NotificationPreference(
              promotions: true,
              newLaunches: true,
              members: true,
              meetExpert: true,
              library: true,
              liveSessions: true,
              onboarding: true),
          future: future,
          builder: (context, snapshot) {
            final NotificationPreference preference = snapshot.data!;
            return ListView(
              padding: const EdgeInsets.all(24.0),
              physics: const BouncingScrollPhysics(),
              children: [
                const Text(
                  'Notifications',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                const Text(
                  'Community',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                NotificationsTile(
                  text: 'Live Sessions',
                  value: preference.liveSessions!,
                  onChanged: (val) {
                    setState(() {
                      preference.liveSessions = val;
                      const NotificationsApi()
                          .setNotificationPreference(preference);
                    });
                  },
                ),
                NotificationsTile(
                  text: 'Members',
                  value: preference.members!,
                  onChanged: (val) {
                    setState(() {
                      preference.members = val;
                      const NotificationsApi()
                          .setNotificationPreference(preference);
                    });
                  },
                ),
                NotificationsTile(
                  text: 'Library',
                  value: preference.library!,
                  onChanged: (val) {
                    setState(() {
                      preference.library = val;
                      const NotificationsApi()
                          .setNotificationPreference(preference);
                    });
                  },
                ),
                NotificationsTile(
                  text: 'Meet an Expert',
                  value: preference.meetExpert!,
                  onChanged: (val) {
                    setState(() {
                      preference.meetExpert = val;
                      const NotificationsApi()
                          .setNotificationPreference(preference);
                    });
                  },
                ),
                const SizedBox(
                  height: 36,
                ),
                const Text(
                  'Offers & Updates',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                NotificationsTile(
                  text: 'Promotions',
                  value: preference.promotions!,
                  onChanged: (val) {
                    setState(() {
                      preference.promotions = val;
                      const NotificationsApi()
                          .setNotificationPreference(preference);
                    });
                  },
                ),
                NotificationsTile(
                  text: 'New launches',
                  value: preference.newLaunches!,
                  onChanged: (val) {
                    setState(() {
                      preference.newLaunches = val;
                      const NotificationsApi()
                          .setNotificationPreference(preference);
                    });
                  },
                ),
              ],
            );
          }),
    );
  }
}
