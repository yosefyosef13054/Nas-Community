import 'package:badges/badges.dart';
import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/api/notification/notifications_api.dart';
import 'package:nas_academy/core/modules/notification/notification.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/app_badges.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/ui/dash/community_view/components/notification_screen/notification_screen.dart';
import 'package:provider/provider.dart';


class NotificationButton extends StatefulWidget {
  const NotificationButton({Key? key}) : super(key: key);

  @override
  State<NotificationButton> createState() => _NotificationButtonState();
}

class _NotificationButtonState extends State<NotificationButton> {
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return FutureBuilder<List<UserNotification>>(
        future: const NotificationsApi().getNotifications(dash.communities.elementAt(dash.communitiesIndex).code ?? "").whenComplete(()async{
          await AppBadge.updateBadgeCount();
        }),
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null){
            List<UserNotification> unReadList = snapshot.data!.where((element) => element.seen == false).toList();

            return IconButton(
              onPressed: (){
                Navigate.push(context, NotificationScreen(refresh: ()=> setState((){}), communityCode: dash.communities.elementAt(dash.communitiesIndex).code ?? ""));
              },
              icon: Badge(
                  shape: BadgeShape.circle,
                  padding: const EdgeInsets.all(5),
                  elevation: 1,
                  showBadge: unReadList.isNotEmpty,
                  position: BadgePosition.topEnd(top: 0, end: 0),
                  badgeColor: Colors.red,
                  child: SvgPicture.asset(Assets.bell, color: Colors.white,)),
            );
          }else {
            return IconButton(
              onPressed: (){
                Navigate.push(context, NotificationScreen(refresh: ()=> setState((){}), communityCode: dash.communities.elementAt(dash.communitiesIndex).code ?? ""));
              },
              icon: SvgPicture.asset(Assets.bell, color: Colors.white,),
            );
          }
        }
    );
  }
}
