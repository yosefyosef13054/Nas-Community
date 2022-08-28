import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';

import 'package:nas_academy/core/modules/todo/todo.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/live_session/live_session.dart';
import 'package:nas_academy/ui/dash/todo/components/swipe_button/swipeable_button.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/local_db/user/user_local_db.dart';
import '../../library/classes/class_details/video_stream/video_player.dart';
import '../../library/library.dart';
import '../../live_session/livesession_details/live_session_details.dart';
import '../../members/members.dart';
import '../../../../core/modules/common/host.dart' as host;

// ignore: must_be_immutable
class TodoBottomSheet extends StatelessWidget {
  TodoBottomSheet({
    required this.item,
    required this.isFinished,
    Key? key,
  }) : super(key: key);
  Todo item;
  bool isFinished = false;
  @override
  Widget build(BuildContext context) {
    final toDo = Provider.of<TodoProvider>(context);

    return StatefulBuilder(builder: (ctx, StateSetter setState) {
      return Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            child: Material(
                color: ColorPlate.neutral100,
                child: SafeArea(
                  top: false,
                  child: Stack(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 24, bottom: 24),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.network(
                                        item.icon.toString(),
                                      ),
                                      const SizedBox(
                                        width: 24,
                                      ),
                                      Visibility(
                                        visible: isFinished,
                                        child: SvgPicture.asset(
                                          "assets/svg/finished.svg",
                                          width: 40,
                                          height: 40,
                                        ),
                                      ),
                                      const Spacer(),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item.title.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  isFinished == true
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: const [
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Hooray! You’ve completed this task!',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 140,
                                            ),
                                          ],
                                        )
                                      : Column(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  right: 24),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  item.description.toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                if (item.type == 'video') {
                                                  final String cookie =
                                                      await UserLocalDB
                                                          .getCookie();
                                                  final headers = {
                                                    'cookie': cookie
                                                  };
                                                  Navigate.push(
                                                      context,
                                                      VideoStreamPlayer(
                                                        // shortLink: video.shortUrl,
                                                        headers: headers,
                                                        hlsLink:
                                                            item.task!.hlsLink!,
                                                      ));
                                                } else if (item.type ==
                                                    'library') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const Library(
                                                                pop: true)),
                                                  );
                                                } else if (item.type ==
                                                    'platform') {
                                                  await launchUrl(Uri.parse(item
                                                      .task!.link
                                                      .toString()));
                                                } else if (item.type ==
                                                    'event') {
                                                  item.task!.id == null
                                                      ? Navigate.push(
                                                          context,
                                                          LiveSessionScreen(
                                                              discover: true,
                                                              id: item
                                                                  .communityId
                                                                  .toString()))
                                                      : Navigate.push(
                                                          context,
                                                          LiveSessionDetailsScreen(
                                                              item: Session(
                                                            id: item.task!.id,
                                                            title: item
                                                                .task!.title,
                                                            description: item
                                                                .task!
                                                                .description,
                                                            startTime: item
                                                                .task!
                                                                .startTime,
                                                            endTime: item
                                                                .task!.endTime,
                                                            cardImgData: null,
                                                            liveLink: item
                                                                .task!.liveLink,
                                                            recordingLink: item
                                                                .task!
                                                                .recordingLink,
                                                            // isActive: item
                                                            //     .task.isActive,
                                                            status: item
                                                                .task!.status,
                                                            type:
                                                                item.task!.type,
                                                            communities: item
                                                                .task!
                                                                .communities,
                                                            host: host.Host(
                                                                firstName: item
                                                                    .task!
                                                                    .host!
                                                                    .firstName,
                                                                lastName: item
                                                                    .task!
                                                                    .host!
                                                                    .lastName,
                                                                profileImage: item
                                                                    .task!
                                                                    .host!
                                                                    .profileImage),
                                                            // createdAt:
                                                            //     item.task!.createdAt,
                                                            lastModifiedTimeStamp:
                                                                item.task!
                                                                    .lastModifiedTimeStamp,
                                                            eventId: item
                                                                .task!.eventId,
                                                            // v: item.task.v,
                                                            attendees: item
                                                                .task!
                                                                .attendees,
                                                            profileImages: item
                                                                .task!
                                                                .profileImages,
                                                            resources: item
                                                                .task!
                                                                .resources,
                                                            // registered:
                                                            //     item.task!.registered,
                                                            shortUrl: item
                                                                .task!.shortUrl,
                                                            createdAt: null,
                                                            isActive: null,
                                                            registered: null,
                                                            v: null,
                                                          )));
                                                } else if (item.type ==
                                                    'members') {
                                                  Navigate.push(
                                                      context,
                                                      const MembersScreen(
                                                        pop: true,
                                                      ));
                                                } else if (item.type ==
                                                    'library') {
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const RecordWatchScreen(
                                                  //               url:
                                                  //                   'https://drive.google.com/file/d/1LQ7BpPDpEy3TCTJFn1odl_CZHqQmg3r_/view'
                                                  //               // item.recordingLink
                                                  //               //     .toString(),
                                                  //               )),
                                                  // );
                                                }
                                              },
                                              child: item.task!.name ==
                                                          'discord' ||
                                                      item.task!.platform ==
                                                          'discord'
                                                  ? Center(
                                                      child: Container(
                                                        height: 96,
                                                        width: 326,
                                                        decoration: BoxDecoration(
                                                            color: ColorPlate
                                                                .neutral97,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12)),
                                                        child: Row(
                                                          children: [
                                                            const SizedBox(
                                                              width: 16,
                                                            ),
                                                            SvgPicture.asset(
                                                              "assets/svg/discord.svg",
                                                              width: 28,
                                                              height: 22,
                                                            ),
                                                            const SizedBox(
                                                              width: 18,
                                                            ),
                                                            const SizedBox(
                                                              width: 250,
                                                              child: Text(
                                                                'Join the community Discord group chat',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontSize:
                                                                        16),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  : item.task!.name ==
                                                          'whatsapp'
                                                      ? Center(
                                                          child: Container(
                                                            height: 96,
                                                            width: 326,
                                                            decoration: BoxDecoration(
                                                                color: ColorPlate
                                                                    .neutral97,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            child: Row(
                                                              children: [
                                                                const SizedBox(
                                                                  width: 16,
                                                                ),
                                                                SvgPicture
                                                                    .asset(
                                                                  "assets/svg/whatsapp.svg",
                                                                ),
                                                                const SizedBox(
                                                                  width: 18,
                                                                ),
                                                                const SizedBox(
                                                                  width: 250,
                                                                  child: Text(
                                                                    'Join the community WhatsApp group chat',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w500,
                                                                        fontSize:
                                                                            16),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          height: 48,
                                                          margin:
                                                              const EdgeInsets
                                                                      .only(
                                                                  right: 24),
                                                          width:
                                                              double.infinity,
                                                          decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: .5,
                                                                  color: ColorPlate
                                                                      .primaryLightBG),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          48),
                                                              color: ColorPlate
                                                                  .neutral100),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Text(
                                                                item.ctaButtonText
                                                                    .toString(),
                                                                style: const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16,
                                                                    color: Colors
                                                                        .black),
                                                              ),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              const Icon(
                                                                Icons
                                                                    .arrow_forward,
                                                                color: Colors
                                                                    .black,
                                                                size: 15,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            Container(
                                              height: 1,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(2),
                                                  color: ColorPlate.neutral95),
                                            ),
                                            const SizedBox(
                                              height: 32,
                                            ),
                                            const Text(
                                              'Swipe right to mark this as completed',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color.fromRGBO(
                                                      117, 119, 122, 1),
                                                  fontSize: 14),
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                  padding: EdgeInsets.zero,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          width: .5,
                                                          color: ColorPlate
                                                              .primaryLightBG),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              48),
                                                      color: ColorPlate
                                                          .primaryDarkBG),
                                                  margin: const EdgeInsets.only(
                                                    right: 24,
                                                  ),
                                                  height: 56,
                                                  width: double.infinity,
                                                  child: Center(
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              45),
                                                      child:
                                                          SwipeableButtonView(
                                                        buttonText:
                                                            'I have completed this',
                                                        buttonColor: const Color
                                                                .fromRGBO(
                                                            24, 170, 121, 1),
                                                        disableColor:
                                                            Colors.black,
                                                        buttontextstyle:
                                                            const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 16,
                                                                color: Color
                                                                    .fromRGBO(
                                                                        0,
                                                                        112,
                                                                        74,
                                                                        1)),
                                                        indicatorColor:
                                                            const AlwaysStoppedAnimation<
                                                                    Color>(
                                                                Colors.green),
                                                        buttonWidget:
                                                            SvgPicture.asset(
                                                          "assets/svg/correct.svg",
                                                          color: Colors.white,
                                                          width: 16,
                                                        ),
                                                        activeColor:
                                                            Colors.white,
                                                        isFinished: isFinished,
                                                        onWaitingProcess: () {
                                                          setState(() =>
                                                              isFinished =
                                                                  true);
                                                          toDo.completeTask(
                                                              item);
                                                        },
                                                        onFinish: () async {},
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  const SizedBox(
                                    height: 25,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      Visibility(
                        visible: isFinished,
                        child: Positioned(
                            bottom: 0,
                            top: 0,
                            right: 0,
                            left: 0,
                            child: Stack(
                              children: [
                                Lottie.asset(
                                  'assets/svg/congrats.json',
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ],
                            )),
                      ),
                      Visibility(
                        visible: isFinished,
                        child: Positioned(
                          bottom: 105,
                          right: 0,
                          left: 0,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                setState(() => isFinished = false);
                                toDo.unCompleteTask(item);
                              },
                              child: const Text(
                                'Mark as incomplete',
                                style: TextStyle(
                                    color: Color.fromRGBO(117, 119, 122, 1),
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isFinished,
                        child: Positioned(
                          bottom: 30,
                          right: 24,
                          left: 24,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: 48,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5,
                                      color: ColorPlate.primaryLightBG),
                                  borderRadius: BorderRadius.circular(48),
                                  color: ColorPlate.neutral100),
                              child: const Center(
                                child: Text(
                                  'Continue',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 30,
                        right: 16,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.close,
                              color: ColorPlate.neutral70,
                            )),
                      )
                    ],
                  ),
                ))),
      );
    });
  }
}
