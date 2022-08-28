import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/launcher.dart';
import 'package:nas_academy/ui/common/my_icons.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ChatMenuButton extends StatelessWidget {
  const ChatMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    if (dash.activeCommunity == null ||
        dash.communities.elementAt(dash.communitiesIndex).id !=
            dash.activeCommunity!.id!) {
      return Container(
        width: 114,
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(48),
            color: const Color(0xFF31C0ED)),
        child: Center(
            child: Shimmer.fromColors(
          highlightColor: Colors.white30,
          baseColor: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(48),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  MyIcons.telegram,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "Chat",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                )
              ],
            ),
          ),
        )),
      );
    } else {
      if (dash.activeCommunity != null &&
          dash.activeCommunity!.platforms.isNotEmpty) {
        return Container(
          width: 114,
          height: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(48),
              color: const Color(0xFF31C0ED)),
          child: Center(
              child: InkWell(
            borderRadius: BorderRadius.circular(48),
            onTap: () {
              Launcher.launch(dash.activeCommunity!.platforms.last);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Launcher.platformIcon(dash.activeCommunity!.platforms.last),
                  color: Colors.white,
                  size: 20,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text(
                  "Chat",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white),
                )
              ],
            ),
          )),
        );
      } else {
        return const SizedBox();
      }
    }
  }
}
