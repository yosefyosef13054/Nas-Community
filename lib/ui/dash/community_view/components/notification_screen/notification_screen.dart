import 'package:flutter/material.dart';
import 'package:nas_academy/core/api/notification/notifications_api.dart';
import 'package:nas_academy/core/modules/notification/notification.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/app_badges.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/common/error_state.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:nas_academy/ui/dash/community_view/components/notification_screen/notification_card.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, this.refresh, required this.communityCode}) : super(key: key);
  final Function? refresh;
  final String? communityCode;
  @override
  NotificationScreenState createState() => NotificationScreenState();
}

class NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }


  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 64,
        elevation: 1,
        shadowColor: ColorPlate.neutral90,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Notification',
          maxLines: 2,
          overflow: TextOverflow.visible,
          softWrap: true,
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorPlate.primaryLightBG),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.black,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child: Visibility(
            visible: dash.loading,
            child: const LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.transparent,
              valueColor:
              AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<UserNotification>>(
        future: const NotificationsApi().getNotifications(widget.communityCode),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null){
            List<UserNotification> notList = snapshot.data!;
            List<UserNotification> unRead = notList.where((element) => element.seen == false).toList();
            if(notList.isNotEmpty){
              if(unRead.isNotEmpty){
                const NotificationsApi().setNotificationSeen(unRead.map((e) => e.id!).toList()).whenComplete(() {
                  AppBadge.updateBadgeCount();
                  if(widget.refresh != null){
                    widget.refresh!();
                  }
                });
              }
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: notList.length,
                itemBuilder: (context, index) {
                  notList.sort((a,b) => b.sentDate!.compareTo(a.sentDate!));
                  return NotificationCard(notification: notList[index],);
                },
              );
            }else {
              return const Center(
                child:  EmptyState(
                  title: "Nothing here yet",
                  icon: Icons.notifications_off,
                ),
              );
            }
          }else if (snapshot.hasError){
            return Center(
              child: ErrorState(
                title: "Something went wrong\n${snapshot.error.toString()}",
                 icon: Icons.notification_important_sharp,
              ),
            );
          }else {
            return const Loading(color: Colors.transparent,);
          }
        }
      ),
    );
  }
}
