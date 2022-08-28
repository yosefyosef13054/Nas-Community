import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/live_session/components/upcoming_item.dart';

import '../../../../core/providers/live_session/live_session_provider.dart';

class UbcomingSessions extends StatelessWidget {
  const UbcomingSessions({
    Key? key,
    required this.liveSessionProvider,
  }) : super(key: key);

  final LiveSessonProvider liveSessionProvider;

  @override
  Widget build(BuildContext context) {
    return liveSessionProvider.getlivesessions!.upcoming.isEmpty
        ? Align(
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                SizedBox(
                  height: 50,
                ),
                Icon(
                  LineIcons.wind,
                  size: 100,
                  color: ColorPlate.tertiaryLightBG,
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Sessions List Is Empty..",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ColorPlate.tertiaryLightBG),
                ),
              ],
            ),
          )
        : ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: liveSessionProvider.getlivesessions!.upcoming.length,
            itemBuilder: (context, index) {
              return UpcomingLiveSessionItem(
                listitem: liveSessionProvider.getlivesessions!.upcoming[index],
                index: index,
              );
            });
  }
}
