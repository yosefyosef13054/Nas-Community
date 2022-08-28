import 'package:flutter/material.dart';
import 'package:nas_academy/core/api/community/community.dart';
import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/community_view/components/dash_app_bar.dart';
import 'package:nas_academy/ui/dash/community_view/components/dash_sliver_body.dart';
import 'package:nas_academy/ui/dash/library/library.dart';
import 'package:nas_academy/ui/dash/live_session/live_session.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/meet_an_expert.dart';
import 'package:nas_academy/ui/dash/members/members.dart';
import 'package:provider/provider.dart';

class CommunityView extends StatefulWidget {
  const CommunityView({Key? key, required this.communityCode})
      : super(key: key);
  final String communityCode;

  @override
  State<CommunityView> createState() => _CommunityViewState();
}

class _CommunityViewState extends State<CommunityView> {
  late DashProvider _dashProvider;
  @override
  void initState() {
    super.initState();
    _dashProvider = Provider.of<DashProvider>(context, listen: false);

    _dashProvider.communityViewPageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _dashProvider.communityViewPageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _dashProvider = Provider.of<DashProvider>(context, listen: false);
    return Scaffold(
        backgroundColor: Colors.white,
        body: FutureBuilder<ActiveCommunity>(
            future: CommunityApi().getActiveCommunity(widget.communityCode),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                ActiveCommunity community = snapshot.data!;
                _dashProvider.setActiveCommunity(community);
                return PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _dashProvider.communityViewPageController,
                  onPageChanged: (i) => _dashProvider.setCommunityViewIndex = i,
                  scrollDirection: Axis.horizontal,
                  children: [
                    CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      anchor: 0.0,
                      slivers: [
                        DashAppBar(community: community),
                        DashSliverBody(community: community),
                      ],
                    ),
                    LiveSessionScreen(
                      id: community.id.toString(),
                    ),
                    const Library(pop: false,),
                    const MembersScreen(),
                    MeetAnExpert(
                      community: community,
                      pop: false,
                    ),
                    MeetAnExpert(
                      community: community,
                      pop: false,
                    ),
                  ],
                );
              } else {
                return const Center(
                  child: Loading(
                    color: Colors.transparent,
                  ),
                );
              }
            }));
  }
}
