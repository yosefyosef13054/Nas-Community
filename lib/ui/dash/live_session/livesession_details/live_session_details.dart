import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/helpers/helper_functions.dart';
import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/live_session/components/comfirm_attend_bottomsheet.dart';
import 'package:nas_academy/ui/dash/live_session/components/record_watch_screen.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LiveSessionDetailsScreen extends StatelessWidget {
  const LiveSessionDetailsScreen({required this.item, Key? key})
      : super(key: key);
  final Session item;
  @override
  Widget build(BuildContext context) {
    final liveSessionProvider = Provider.of<LiveSessonProvider>(context);
    String fullDate =
        DateFormat('EEEE, d MMMM').format(item.startTime!.toLocal());
    String startTimeHour = DateFormat.jm().format(item.startTime!.toLocal());
    String endTimeHour = DateFormat.jm().format(item.endTime!.toLocal());
    return Scaffold(
      backgroundColor: ColorPlate.neutral100,
      appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 60,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      item.title.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: ColorPlate.primaryLightBG),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Calendar_Event 16.svg",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          fullDate,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorPlate.primaryLightBG),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Clock 16.svg",
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '$startTimeHour - $endTimeHour',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorPlate.primaryLightBG),
                        ),
                        const Spacer(),
                        Theme(
                          data: Theme.of(context).copyWith(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent),
                          child: PopupMenuButton<String>(
                            icon: const Icon(
                              Icons.error_outline_outlined,
                              size: 24,
                              color: ColorPlate.tertiaryLightBG,
                            ),
                            elevation: 2,
                            color: const Color.fromRGBO(0, 0, 0, 0.75),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem<String>(
                                  height: 32,
                                  child: Text(
                                    "Shown in your timezone: ${DateTime.now().timeZoneName} (GMT${DateTime.now().timeZoneOffset.inHours.isNegative ? "" : "+"}${getTimeString(DateTime.now().timeZoneOffset.inMinutes)})",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                    ),
                                  ),
                                  value: "Not now",
                                ),
                              ];
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          "assets/svg/Location.svg",
                          height: 22,
                          width: 22,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () async {
                            item.liveLink!.contains('http')
                                ? await launchUrl(Uri.parse(item.liveLink!))
                                : await launchUrl(
                                    Uri.parse('https://' + item.liveLink!));
                          },
                          child: const Text(
                            'On Zoom',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ColorPlate.secondaryLightBG,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            item.host.profileImage.toString(),
                            width: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Hosted by',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: ColorPlate.secondaryLightBG),
                            ),
                            Text(
                              item.host.firstName.toString() +
                                  item.host.lastName.toString(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: ColorPlate.secondaryLightBG),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      height: 1,
                      margin: const EdgeInsets.symmetric(vertical: 32),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: const Color.fromRGBO(240, 241, 244, 1)),
                    ),
                    item.description!.isEmpty == true
                        ? Container()
                        : const Text(
                            'About',
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color: ColorPlate.primaryLightBG),
                          ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      item.description.toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorPlate.primaryLightBG),
                    ),
                    item.resources == null || item.resources!.isEmpty
                        ? const SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 1,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 32),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color:
                                        const Color.fromRGBO(240, 241, 244, 1)),
                              ),
                              const Text(
                                'Resources',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorPlate.primaryLightBG),
                              ),
                              const SizedBox(
                                height: 32,
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  // itemCount: item.resources!.length,
                                  itemCount: 3,
                                  itemBuilder: (context, index) {
                                    String? fullDate;
                                    String? startTimeHour;
                                    String? endTimeHour;

                                    Host? host;
                                    String? image;
                                    if (item.resources![index].type ==
                                        'event') {
                                      fullDate = DateFormat('EEEE, d MMMM')
                                          .format(DateTime.parse(item
                                              .resources![index]
                                              .object!
                                              .startTime!));
                                      startTimeHour = DateFormat.jm().format(
                                          DateTime.parse(item.resources![index]
                                              .object!.startTime!));
                                      endTimeHour = DateFormat.jm().format(
                                          DateTime.parse(item.resources![index]
                                              .object!.endTime!));
                                      host =
                                          item.resources![index].object!.host;
                                      image = host!.profileImage;
                                    }

                                    return item.resources![index].type ==
                                            'event'
                                        ? InkWell(
                                            onTap: () {
                                              //  Navigate.push(
                                              //      context, LiveSessionDetailsScreen(item: item),
                                              //      offset: const Offset(
                                              //        1,
                                              //        0,
                                              //      ));
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(16),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .75,
                                              decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      246, 247, 249, 1),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12)),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    item.resources![index].title
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 18,
                                                        color: ColorPlate
                                                            .primaryLightBG),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/svg/Calendar_Event 16.svg",
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        fullDate.toString(),
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color: ColorPlate
                                                                .primaryLightBG),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/svg/Clock 16.svg",
                                                        height: 16,
                                                        width: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        '$startTimeHour - $endTimeHour',
                                                        style: const TextStyle(
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontSize: 14,
                                                            color: ColorPlate
                                                                .primaryLightBG),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 26,
                                                  ),
                                                  Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.network(
                                                          image.toString(),
                                                          width: 30,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 8,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                            'Hosted by',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                color: ColorPlate
                                                                    .secondaryLightBG),
                                                          ),
                                                          Text(
                                                            item
                                                                    .resources![
                                                                        index]
                                                                    .object!
                                                                    .host!
                                                                    .firstName
                                                                    .toString() +
                                                                item
                                                                    .resources![
                                                                        index]
                                                                    .object!
                                                                    .host!
                                                                    .lastName
                                                                    .toString(),
                                                            style: const TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 12,
                                                                color: ColorPlate
                                                                    .secondaryLightBG),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    height: 2,
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(2),
                                                        color: const Color
                                                                .fromRGBO(
                                                            240, 241, 244, 1)),
                                                  ),
                                                  item.resources![index].object!
                                                              .recordingLink ==
                                                          null
                                                      ? Container()
                                                      : InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          RecordWatchScreen(
                                                                            url:
                                                                                // 'https://drive.google.com/file/d/1LQ7BpPDpEy3TCTJFn1odl_CZHqQmg3r_/view'
                                                                                item.resources![index].object!.recordingLink.toString(),
                                                                          )),
                                                            );
                                                          },
                                                          child: Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Container(
                                                              height: 36,
                                                              width: 175,
                                                              decoration:
                                                                  BoxDecoration(
                                                                border: Border.all(
                                                                    width: .5,
                                                                    color: ColorPlate
                                                                        .primaryLightBG),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            48),
                                                                color: Colors
                                                                    .transparent,
                                                              ),
                                                              child: Center(
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: const [
                                                                    Icon(
                                                                      Icons
                                                                          .play_arrow,
                                                                      size: 16,
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          9.34,
                                                                    ),
                                                                    Text(
                                                                      'Watch recording',
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .w500,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              ColorPlate.primaryLightBG),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : item.resources![index].type ==
                                                'resource'
                                            ? InkWell(
                                                onTap: () async {
                                                  item.resources![index].object!
                                                          .link!
                                                          .contains('http')
                                                      ? await launchUrl(
                                                          Uri.parse(item
                                                              .resources![index]
                                                              .object!
                                                              .link!))
                                                      : await launchUrl(
                                                          Uri.parse('https://' +
                                                              item
                                                                  .resources![
                                                                      index]
                                                                  .object!
                                                                  .link!));
                                                },
                                                child: Container(
                                                  height: 110,
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 30),
                                                  padding:
                                                      const EdgeInsets.all(16),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .75,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromRGBO(
                                                              246, 247, 249, 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12)),
                                                  child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        SvgPicture.asset(
                                                          "assets/svg/link.svg",
                                                          width: 60,
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              item
                                                                  .resources![
                                                                      index]
                                                                  .object!
                                                                  .title
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  color: ColorPlate
                                                                      .secondaryLightBG),
                                                            ),
                                                            const SizedBox(
                                                              height: 8,
                                                            ),
                                                            Text(
                                                              item
                                                                  .resources![
                                                                      index]
                                                                  .object!
                                                                  .description
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 18,
                                                                  color: ColorPlate
                                                                      .primaryLightBG),
                                                            ),
                                                            const Spacer(),
                                                            Text(
                                                              item
                                                                  .resources![
                                                                      index]
                                                                  .object!
                                                                  .type
                                                                  .toString(),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                              style: const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  color: ColorPlate
                                                                      .secondaryLightBG),
                                                            ),
                                                          ],
                                                        ),
                                                        const Spacer(),
                                                        SvgPicture.asset(
                                                          "assets/svg/shareLink.svg",
                                                          width: 25,
                                                        ),
                                                        const SizedBox(
                                                          width: 4,
                                                        )
                                                      ]),
                                                ),
                                              )
                                            : Container();
                                  }),
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
      bottomNavigationBar: liveSessionProvider.getattendingSessionsIds
                  .contains(item.id) ==
              true
          ? Column(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color.fromRGBO(240, 241, 244, 1)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/svg/correct.svg",
                      width: 14,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'You’re attending, see you!',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: ColorPlate.primaryLightBG),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                liveSessionProvider.getnotificaitonsGranted == false
                    ? Container()
                    : InkWell(
                        onTap: () async {
                          liveSessionProvider.notifyMe(context);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: const EdgeInsets.only(right: 24, left: 24),
                            height: 48,
                            width: double.infinity,
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "assets/svg/notify_me.svg",
                                    height: 20,
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 9.34,
                                  ),
                                  const Text(
                                    'Notify me',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: ColorPlate.primaryLightBG),
                                  ),
                                ],
                              ),
                            ),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: .5,
                                    color: ColorPlate.primaryLightBG),
                                borderRadius: BorderRadius.circular(48),
                                color: ColorPlate.primaryDarkBG),
                          ),
                        ),
                      ),
                const SizedBox(
                  height: 12,
                ),
                InkWell(
                  onTap: () {
                    final Event event = Event(
                      title: item.title!,
                      description: item.description!,
                      location: 'Event location',
                      startDate: item.startTime!.toLocal(),
                      endDate: item.endTime!.toLocal(),
                      iosParams: const IOSParams(
                        reminder: Duration(hours: 1),
                      ),
                    );

                    Add2Calendar.addEvent2Cal(event);
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.only(right: 24, left: 24),
                      height: 48,
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/add-to-calendar.svg",
                              height: 20,
                              width: 20,
                            ),
                            const SizedBox(
                              width: 9.34,
                            ),
                            const Text(
                              'Add to calendar',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ColorPlate.primaryLightBG),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: .5, color: ColorPlate.primaryLightBG),
                          borderRadius: BorderRadius.circular(48),
                          color: ColorPlate.primaryDarkBG),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 1,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: const Color.fromRGBO(240, 241, 244, 1)),
                ),
                InkWell(
                  onTap: () async {
                    showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      duration: const Duration(milliseconds: 300),
                      animationCurve: Curves.easeInOut,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) {
                        return ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(28),
                              topRight: Radius.circular(28),
                            ),
                            child: ConfirmAttendingSheet(
                              item: item,
                            ));
                      },
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          margin: const EdgeInsets.only(right: 24, left: 24),
                          height: 48,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              'I’m going',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: ColorPlate.primaryLightBG),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              color: ColorPlate.yellow70),
                        ),
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
