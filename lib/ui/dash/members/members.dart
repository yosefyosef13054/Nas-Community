import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/common/my_icons.dart';
import 'package:nas_academy/ui/dash/members/all/all.dart';
import 'package:nas_academy/ui/dash/members/filters/filters.dart';
import 'package:nas_academy/ui/dash/members/nas_team/nas_team_members.dart';
import 'package:nas_academy/ui/dash/members/near_me/near_me_members.dart';
import 'package:nas_academy/ui/dash/members/new/new_members.dart';
import 'package:provider/provider.dart';

class MembersScreen extends StatefulWidget {
  const MembersScreen({Key? key, this.pop}) : super(key: key);
  final bool? pop;

  @override
  State<MembersScreen> createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen>
    with SingleTickerProviderStateMixin {
  late DashProvider _dash;
  late ScrollController _scrollController;
  late Future future;

  @override
  void initState() {
    super.initState();
    _dash = Provider.of<DashProvider>(context, listen: false);
    future = _dash.getMembers();
    _dash.setMembersTabController = TabController(length: 3, vsync: this);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset < 90 && _scrollController.offset > 40) {
        setState(() {
          titlePadding = (_scrollController.offset / 1.6).round().toDouble();
        });
      }
      if (_scrollController.offset > 90 && titlePadding != 55) {
        setState(() {
          titlePadding = 55;
        });
      }
      if (_scrollController.offset < 40 && titlePadding != 25) {
        setState(() {
          titlePadding = 25;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _dash.membersTabController.dispose();
    _scrollController.dispose();
  }

  double titlePadding = 24;
  double appBarSize = 200;
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return ChangeNotifierProvider<MembersProvider>(
      create: (context) => MembersProvider(),
      child:
          Consumer<MembersProvider>(builder: (context, membersProvider, child) {
        return Scaffold(
          backgroundColor: ColorPlate.primaryDarkBG,
          body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  forceElevated: true,
                  primary: true,
                  systemOverlayStyle: SystemUiOverlayStyle.dark,
                  backgroundColor: ColorPlate.primaryDarkBG,
                  elevation: 1,
                  centerTitle: false,
                  actions: [
                    IconButton(
                        splashRadius: 25,
                        onPressed: () {
                          showBarModalBottomSheet(
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(28),
                                topRight: Radius.circular(28),
                              ),
                            ),
                            expand: false,
                            context: context,
                            duration: const Duration(milliseconds: 300),
                            animationCurve: Curves.easeInOut,
                            backgroundColor: Colors.transparent,
                            builder: (context) =>
                                ChangeNotifierProvider<MembersProvider>.value(
                                    value: membersProvider,
                                    child: const FiltersSheet()),
                          );
                        },
                        icon: const Icon(
                          MyIcons.filter,
                          color: Colors.black,
                          size: 20,
                        )),
                  ],
                  leading: widget.pop == true
                      ? IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            size: 18,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        )
                      : IconButton(
                          splashRadius: 25,
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            dash.drawerController.toggle!();
                          },
                        ),
                  collapsedHeight: 65,
                  expandedHeight: 200,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: false,
                    title: const Text(
                      "Members",
                      style: TextStyle(color: Colors.black),
                    ),
                    titlePadding:
                        EdgeInsets.only(bottom: 70, left: titlePadding),
                    expandedTitleScale: 1.5,
                  ),
                  bottom: TabBar(
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    indicatorColor: Colors.black,
                    controller: dash.membersTabController,
                    labelColor: Colors.black,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: Colors.grey[800]!,
                    onTap: (index) => setState(() {}),
                    tabs: const [
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Tab(
                            text: "All",
                          )),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Tab(
                            text: "New",
                          )),
                      FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Tab(
                            text: "Near Me",
                          )),
                      // FittedBox(
                      //     fit: BoxFit.scaleDown,
                      //     child: Tab(
                      //       text: "Nas Team",
                      //     )),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    MembersBody(
                      future: future,
                    )
                  ]),
                ),
              ]),
        );
      }),
    );
  }
}

class MembersBody extends StatelessWidget {
  const MembersBody({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future future;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              65 -
              MediaQuery.of(context).padding.top -
              45),
      child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Child(
                index: dash.membersTabController.index,
              );
            } else {
              return const Center(
                child: Loading(
                  color: Colors.transparent,
                ),
              );
            }
          }),
    );
  }
}

class Child extends StatelessWidget {
  const Child({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    switch (index) {
      case 0:
        return const AllMembers();
      case 1:
        return const NewMembers();
      case 2:
        return const NearMeMembers();
      case 3:
        return const NasTeamMembers();
      default:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                "Empty List ..",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: ColorPlate.tertiaryLightBG),
              ),
            ],
          ),
        );
    }
  }
}
