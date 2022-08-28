import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/community/community/community.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/dash/components/chat_button.dart';
import 'package:nas_academy/ui/dash/components/drawer_list_item.dart';
import 'package:nas_academy/ui/dash/discover/community_page/why_join_community_page.dart';
import 'package:nas_academy/ui/dash/settings/settings_page.dart';
import 'package:nas_academy/ui/dash/user_profile/profile.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final dash = Provider.of<DashProvider>(context);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0.0,
        backgroundColor: ColorPlate.neutral95,
      ),
      backgroundColor: ColorPlate.neutral95,
      body: ListView(
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Column(
                          children: dash.communities
                              .map((e) => CommunityTabIcon(community: e))
                              .toList(),
                        ),
                        InkWell(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: dash.communitiesIndex ==
                                          dash.communities.length
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 1.5),
                            ),
                            padding: const EdgeInsets.all(5),
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * .03,
                                vertical: 4),
                            child: SvgPicture.asset(
                              "assets/svg/explore.svg",
                            ),
                          ),
                          onTap: () {
                            dash.drawerController.close!();
                            dash.communitiesPageController.jumpToPage(dash.communities.length);
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: dash.communitiesIndex == dash.communities.length
                        ? const DiscoveryMenuView()
                        : Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 40, horizontal: 16),
                            height: MediaQuery.of(context).size.height * .93,
                            decoration: BoxDecoration(
                                color: ColorPlate.primaryDarkBG,
                                borderRadius: BorderRadius.circular(28)),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Builder(builder: (context) {
                                    if (dash.activeCommunity != null) {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dash.activeCommunity!.title!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  color: ColorPlate
                                                      .primaryLightBG),
                                            ),
                                            Text(
                                              dash.activeCommunity!.by!,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  color: ColorPlate
                                                      .secondaryLightBG),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      return Container(
                                        margin: const EdgeInsets.only(left: 8),
                                        child: Shimmer.fromColors(
                                          baseColor: Colors.grey,
                                          highlightColor: Colors.white,
                                          child: const Text(
                                            "Loading ... ",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 18,
                                                color:
                                                    ColorPlate.primaryLightBG),
                                          ),
                                        ),
                                      );
                                    }
                                  }),
                                  const SizedBox(
                                    height: 80,
                                  ),
                                  const DrawerListItem(index: 0, text: "Home"),
                                  const DrawerListItem(
                                      index: 1, text: "Live Sessions"),
                                  const DrawerListItem(
                                      index: 2, text: "Library"),
                                  const DrawerListItem(
                                      index: 3, text: "Members"),
                                  Visibility(
                                      visible: dash.activeCommunity != null &&
                                          dash.communities
                                                  .elementAt(
                                                      dash.communitiesIndex)
                                                  .id ==
                                              dash.activeCommunity!.id! &&
                                          dash.activeCommunity!.trainer != null,
                                      child: const DrawerListItem(
                                          index: 4, text: "Meet an Expert")),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  const ChatMenuButton()
                                ]),
                          ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigate.push(context, const SettingPage());
                      },
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorPlate.neutral90),
                        child: const Center(
                          child: Icon(Icons.settings),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                        onTap: () async {
                          // await Auth().logOut(context);
                          Navigate.push(context, const ProfilePage());
                        },
                        child: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * .03,
                              vertical: 4),
                          child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                  user!.learner.profileImage ?? ""),
                              radius: 24),
                        )
                        // child: Image.network(, height: 48, width: 48,)),
                        ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CommunityTabIcon extends StatelessWidget {
  const CommunityTabIcon({Key? key, required this.community}) : super(key: key);
  final Community community;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final int index = dash.communities.indexOf(community);
    switch (community.status){
      case ApplicationStatusType.current : {
        return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                  color: index == dash.communitiesIndex
                      ? Colors.black
                      : Colors.transparent,
                  width: 1.5),
            ),
            padding: const EdgeInsets.all(2),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .03, vertical: 4),
            child: InkWell(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                onTap: () async {
                  dash.drawerController.close!();
                  dash.communitiesPageController.jumpToPage(index);
                },
                child: Image.network(
                  community.thumbnailImgData!.mobileImageData!.src!,
                  height: 48,
                  width: 48,
                )));
      }
      case ApplicationStatusType.pending : {
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Stack(
            alignment: Alignment.bottomCenter,
            fit: StackFit.passthrough,
            children: [
              Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(2),
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .03, vertical: 4),
                  child: Image.network(
                    community.thumbnailImgData!.mobileImageData!.src!,
                    height: 48,
                    width: 48,
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 18,
                  width: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: ColorPlate.neutral10,
                  ),
                  child : const Center(
                    child: Text("Applied", style: TextStyle(color: Colors.white, fontSize: 12),),
                  ),
                ),
              ),
            ],
          ),
        );
      }
      default : return const SizedBox();
    }
  }
}

class DiscoveryMenuView extends StatelessWidget {
  const DiscoveryMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      height: MediaQuery.of(context).size.height * .93,
      decoration: BoxDecoration(
          color: ColorPlate.primaryDarkBG,
          borderRadius: BorderRadius.circular(28)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Discovery",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Find communities from your favourite creators all over the world",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: ColorPlate.secondaryLightBG),
              ),
              const SizedBox(
                height: 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  height: 45,
                  width: 100,
                  child: OutlinedButton(
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100))),
                        side: MaterialStateProperty.all(const BorderSide(
                            color: ColorPlate.secondaryLightBG))),
                    onPressed: () {
                      dash.drawerController.close!();
                    },
                    child: const Text(
                      "Explore",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                // height: 144,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: ColorPlate.yellow70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Why Join Communities?",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            elevation: MaterialStateProperty.all(0)),
                        onPressed: () {
                          dash.drawerController.close!();
                          Navigate.push(context, const WhyJoinCommunityPage());
                        },
                        child: const Text("Learn more")),
                  ],
                ),
              ),
              Positioned(
                right: -25,
                top: 30,
                child: SvgPicture.asset(
                  Assets.whyJoinMenu,
                  height: 100,
                  width: 100,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
