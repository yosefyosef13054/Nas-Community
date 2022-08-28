import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';

import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/live_session/components/attending_sessions.dart';
import 'package:nas_academy/ui/dash/live_session/components/past_sessions.dart';
import 'package:nas_academy/ui/dash/live_session/components/upcoming_sessions.dart';

import 'package:provider/provider.dart';

class LiveSessionScreen extends StatefulWidget {
  const LiveSessionScreen(
      {Key? key, required this.id, this.discover})
      : super(key: key);
  final String id;
  final bool? discover;

  @override
  State<LiveSessionScreen> createState() => _LiveSessionScreenState();
}

class _LiveSessionScreenState extends State<LiveSessionScreen> with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  late Future future;
  void init() async {
    final liveSessionProvider = Provider.of<LiveSessonProvider>(context, listen: false);
    future = liveSessionProvider.getLists(widget.id);
    liveSessionProvider.checkPermission();
    liveSessionProvider.setTabController = TabController(length: 3, vsync: this);

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
  void initState() {
    init();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    // _tabController.dispose();
    _scrollController.dispose();
  }

  double titlePadding = 25;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    var liveSessionProvider = Provider.of<LiveSessonProvider>(context);
    return Scaffold(
      backgroundColor: ColorPlate.neutral100,
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              forceElevated: true,
              primary: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: ColorPlate.neutral100,
              elevation: 1,
              centerTitle: false,
              leading: widget.discover == true
                  ? IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 18,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  : IconButton(
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
                  "Live Sessions",
                  style: TextStyle(color: Colors.black),
                ),
                titlePadding: EdgeInsets.only(bottom: 70, left: titlePadding),
                expandedTitleScale: 1.5,
              ),
              bottom: TabBar(
                overlayColor: MaterialStateProperty.all(Colors.transparent),
                indicatorColor: Colors.black,
                controller: liveSessionProvider.tabController,
                labelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                unselectedLabelColor: Colors.grey[800]!,
                onTap: (index) => setState(() {}),
                tabs: const [
                  Tab(
                    text: "Attending",
                  ),
                  Tab(
                    text: "Upcoming",
                  ),
                  Tab(
                    text: "Past",
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Body(
                  future: future,
                )
              ]),
            ),
          ]),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future future;

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    final LiveSessionProvider = Provider.of<LiveSessonProvider>(context);
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
                index: LiveSessionProvider.tabController.index,
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
    final liveSessionProvider = Provider.of<LiveSessonProvider>(context);
    switch (index) {
      case 0:
        return AttendingSessions(liveSessionProvider: liveSessionProvider);
      case 1:
        return UbcomingSessions(liveSessionProvider: liveSessionProvider);
      case 2:
        return PastSessionsList(liveSessionProvider: liveSessionProvider);

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
