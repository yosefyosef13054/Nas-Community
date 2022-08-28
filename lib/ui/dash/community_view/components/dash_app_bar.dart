import 'dart:ui';
import "package:flutter/material.dart";
import 'package:nas_academy/core/helpers/helper_functions.dart';
import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/launcher.dart';
import 'package:nas_academy/ui/dash/community_view/components/notification_button.dart';
import 'package:provider/provider.dart';

class DashAppBar extends StatelessWidget {
  const DashAppBar({Key? key, required this.community}) : super(key: key);
  final ActiveCommunity community;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final user = Provider.of<User?>(context);
    return SliverLayoutBuilder(builder: (context, constraint) {
      return SliverAppBar(
        backgroundColor: Colors.black,
        toolbarHeight: 60,
        collapsedHeight: 75,
        elevation: 0.0,
        shadowColor: Colors.white,
        excludeHeaderSemantics: true,
        expandedHeight: 215.0,
        floating: true,
        snap: false,
        pinned: true,
        stretch: true,
        actions: [
          Row(
            children: community.platforms
                .map((platform) => IconButton(
                      icon: Icon(Launcher.platformIcon(platform)),
                      onPressed: () async {
                        await Launcher.launch(platform);
                      },
                    ))
                .toList(),
          ),
          const NotificationButton()
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(community.title!,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                )),
            Text(
              community.by!,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.white),
            ),
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: InkWell(
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            onTap: () {
              dash.drawerController.toggle!();
            },
            child: Stack(
              children: [
                Image.network(
                  community.thumbnailImgData!.mobileImageData!.src!,
                  height: community
                      .thumbnailImgData!.mobileImageData!.meta!.height!,
                  width:
                      community.thumbnailImgData!.mobileImageData!.meta!.width!,
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFE1E2E5)),
                      child: const Center(
                        child: Icon(
                          Icons.menu,
                          size: 13,
                          color: Colors.black,
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ),
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          return FlexibleSpaceBar(
            collapseMode: CollapseMode.parallax,
            titlePadding: EdgeInsets.zero,
            background: Stack(
              alignment: Alignment.centerLeft,
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()..scale(1.4, 1.4),
                      child: Image.network(
                          community.thumbnailImgData!.mobileImageData!.src!,
                          fit: BoxFit.cover,
                          alignment: Alignment.bottomCenter),
                    ),
                  ),
                ),
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    stops: [0.0, 0.98],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
                  width: double.infinity,
                ),
                Positioned(
                  top: MediaQuery.of(context).size.height * .15,
                  left: 13,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello ${user!.learner.firstName}',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        'For you this week',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: Colors.white),
                      ),
                      Text(
                        getDatesForCurrentWeek(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                            color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            expandedTitleScale: 1,
          );
        }),
      );
    });
  }
}
