import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/notification/notification.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/services/notification_action.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/time_formatter.dart';
import 'package:provider/provider.dart';

class NotificationCard extends StatefulWidget {
  const NotificationCard({Key? key, required this.notification})
      : super(key: key);
  final UserNotification notification;

  @override
  State<NotificationCard> createState() => _NotificationCardState();
}

class _NotificationCardState extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final liveSessions = Provider.of<LiveSessonProvider>(context);
    return InkWell(
      onTap: ()async{
        if( widget.notification.data != null){
          try{
            dash.setLoading = true;
            await NotificationScreenAction(
                context: context,
                type: widget.notification.type,
                communityCode: widget.notification.data?.communityCode,
                eventID: widget.notification.data?.eventObjectId,
                liveSessions: liveSessions,
                dash: dash,
              openScreenOnOther: false
            ).handleNotificationCardClick();
            if(widget.notification.seen != true){
              setState((){widget.notification.seen = true;});
            }
            dash.setLoading = false;
          }catch (e){
            dash.setLoading = false;
            rethrow;
          }
        }else {
          if(widget.notification.seen != true){
            setState((){widget.notification.seen = true;});
          }
        }
      },
      child: Container(
        color: widget.notification.seen ? ColorPlate.neutral100 : ColorPlate.neutral97,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        width: double.infinity,
        child: Row(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(
              widget.notification.icon ?? "",
              height: 64,
              width: 64,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .45,
                  child: Text(
                    widget.notification.title ?? "Notification",
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPlate.primaryLightBG),
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .6,
                child: Text(
                  widget.notification.body ?? "",
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPlate.secondaryLightBG),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Visibility(
                visible: widget.notification.sentDate != null,
                child: Text(
                  "${TimeFormatter.dateOrToday(widget.notification.sentDate!)}  ${TimeFormatter.timeInTwelveSys(widget.notification.sentDate!)}",
                  maxLines: 2,
                  overflow: TextOverflow.visible,
                  softWrap: true,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ColorPlate.tertiaryLightBG),
                ),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
