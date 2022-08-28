import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/live_session/components/attending_item.dart';

import '../../../../core/providers/live_session/live_session_provider.dart';

class AttendingSessions extends StatelessWidget {
  const AttendingSessions({
    Key? key,
    required this.liveSessionProvider,
  }) : super(key: key);

  final LiveSessonProvider liveSessionProvider;

  @override
  Widget build(BuildContext context) {
    return liveSessionProvider.getlivesessions!.attending.isEmpty
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
        : Container(
            color: ColorPlate.neutral100,
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    liveSessionProvider.getlivesessions!.attending.length,
                itemBuilder: (context, index) {
                  return AttendingLiveSessionItem(
                    listitem:
                        liveSessionProvider.getlivesessions!.attending[index],
                    index: index,
                  );
                }),
          );
  }
}
