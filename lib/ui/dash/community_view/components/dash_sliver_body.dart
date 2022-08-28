import 'package:card_swiper/card_swiper.dart';
import "package:flutter/material.dart";
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/ui/dash/community_view/components/community_video.dart';
import 'package:nas_academy/ui/dash/community_view/components/featured_member_card.dart';
import 'package:nas_academy/ui/dash/community_view/components/live_session_list_item.dart';
import 'package:nas_academy/ui/dash/community_view/components/todo_section.dart';
import 'package:nas_academy/ui/dash/library/library.dart';
import 'package:nas_academy/ui/dash/live_session/live_session.dart';
import 'package:nas_academy/ui/dash/members/members.dart';
import 'package:provider/provider.dart';

class DashSliverBody extends StatefulWidget {
  const DashSliverBody({
    Key? key,
    required this.community,
  }) : super(key: key);
  final ActiveCommunity community;

  @override
  State<DashSliverBody> createState() => _DashSliverBodyState();
}

class _DashSliverBodyState extends State<DashSliverBody> {
  @override
  void initState() {
    super.initState();
    final _dashProvider = Provider.of<DashProvider>(context, listen: false);
    final todo = Provider.of<TodoProvider>(context, listen: false);
    UserLocalDB.setOriantationShow(true);
    todo.init(_dashProvider.activeCommunity!.id!);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate.fixed([
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top,
          ),
          child: Stack(
            children: [
              Container(
                height: 30,
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0.1,
                    0.4,
                    0.6,
                    0.9,
                  ],
                  colors: [
                    Colors.black.withOpacity(0.95),
                    Colors.black.withOpacity(0.97),
                    Colors.black.withOpacity(1),
                    Colors.black,
                  ],
                )),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 30),
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TodoDashView(),
                        Visibility(
                          visible: widget.community.upcomingEvents.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Live Sessions',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                ),
                                onTap: () {
                                  Navigate.push(
                                    context,
                                    LiveSessionScreen(
                                      discover: true,
                                      id: widget.community.id.toString(),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 180,
                                child: Swiper(
                                  viewportFraction: 0.9,
                                  loop: false,
                                  physics: const BouncingScrollPhysics(),
                                  //padding: const EdgeInsets.symmetric(horizontal: 20),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.community.upcomingEvents.length,
                                  itemBuilder: (context, index) {
                                    return LiveSessionListItem(
                                      event: widget
                                          .community.upcomingEvents[index],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.community.featuredMembers.isNotEmpty,
                          child: Column(
                            children: [
                              ListTile(
                                title: const Text(
                                  'Featured members',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                ),
                                onTap: () {
                                  Navigate.push(
                                      context,
                                      const MembersScreen(
                                        pop: true,
                                      ));
                                },
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: double.infinity,
                                height: 150,
                                child: Swiper(
                                  viewportFraction: 0.9,
                                  loop: false,
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                      widget.community.featuredMembers.length,
                                  itemBuilder: (context, index) {
                                    return FeaturedMemberCard(
                                        member: widget
                                            .community.featuredMembers[index]);
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 60,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: widget.community.communityVideos.isNotEmpty,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: const Text(
                                  'Learn something today',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20,
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 17,
                                ),
                                onTap: () {
                                  Navigate.push(
                                      context, const Library(pop: true));
                                },
                              ),
                              SizedBox(
                                height: 300,
                                child: Swiper(
                                    viewportFraction: 0.9,
                                    loop: false,
                                    physics: const BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        widget.community.communityVideos.length,
                                    itemBuilder: (context, index) {
                                      return CommunityVideoCard(
                                        video: widget
                                            .community.communityVideos[index],
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}
