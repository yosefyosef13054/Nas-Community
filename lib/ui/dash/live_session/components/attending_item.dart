import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/modules/live_session/main_live_sessions.dart';
import '../livesession_details/live_session_details.dart';

class AttendingLiveSessionItem extends StatelessWidget {
  const AttendingLiveSessionItem(
      {Key? key, required this.index, required this.listitem})
      : super(key: key);
  final Attending listitem;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        index != 0
            ? Container(
                height: 1,
                margin:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: const Color.fromRGBO(240, 241, 244, 1)),
              )
            : Container(),
        Container(
          margin: const EdgeInsets.only(left: 25, bottom: 24),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              listitem.title.toString(),
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: listitem.sessions!.length,
              itemBuilder: (context, index) {
                DateTime currentDate = DateTime.now();
                Session item = listitem.sessions![index];
                String fullDate = DateFormat('EEEE, d MMMM')
                    .format(item.startTime!.toLocal());
                int differenceDays =
                    item.startTime!.difference(currentDate).inDays;
                var differenceMinuts =
                    item.startTime!.difference(currentDate).inMinutes;
                String weekday =
                    DateFormat('EE').format(item.startTime!.toLocal());
                String monthDay =
                    DateFormat('d').format(item.startTime!.toLocal());
                String daymonth =
                    DateFormat(' d MMMM').format(item.startTime!.toLocal());
                String startTimeHour =
                    DateFormat.jm().format(item.startTime!.toLocal());
                String endTimeHour =
                    DateFormat.jm().format(item.endTime!.toLocal());

                return item.isActive == false
                    ? Container()
                    : Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              width: 33,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  weekday,
                                  style: const TextStyle(
                                      color: ColorPlate.secondaryLightBG,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                                Text(
                                  monthDay,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            InkWell(
                              onTap: () {
                                Navigate.push(context,
                                    LiveSessionDetailsScreen(item: item),
                                    offset: const Offset(
                                      1,
                                      0,
                                    ));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: MediaQuery.of(context).size.width * .75,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(246, 247, 249, 1),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                          color: ColorPlate.primaryLightBG),
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
                                        differenceMinuts < 1
                                            ? Row(
                                                children: [
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    height: 8,
                                                    width: 8,
                                                    decoration: BoxDecoration(
                                                        color: Colors.red,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                  ),
                                                ],
                                              )
                                            : Container(),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        item.startTime!
                                                    .toLocal()
                                                    .isBefore(DateTime.now()) &&
                                                item.endTime!
                                                    .toLocal()
                                                    .isAfter(DateTime.now())
                                            ? Row(
                                                children: [
                                                  Text(
                                                    differenceDays == 1
                                                        ? 'Tomorrow'
                                                        : 'Happening now',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color: Colors.orange),
                                                  ),
                                                  Text(
                                                    ', $daymonth',
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 14,
                                                        color: ColorPlate
                                                            .primaryLightBG),
                                                  ),
                                                ],
                                              )
                                            : Text(
                                                fullDate,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14,
                                                    color: ColorPlate
                                                        .primaryLightBG),
                                              )
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
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14,
                                              color: ColorPlate.primaryLightBG),
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
                                              BorderRadius.circular(25),
                                          child: Image.network(
                                            item.host.profileImage.toString(),
                                            width: 30,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Hosted by',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                  color: ColorPlate
                                                      .secondaryLightBG),
                                            ),
                                            Text(
                                              item.host.firstName.toString() +
                                                  item.host.lastName.toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w500,
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
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(2),
                                          color: const Color.fromRGBO(
                                              240, 241, 244, 1)),
                                    ),
                                    differenceMinuts < 1
                                        ? InkWell(
                                            onTap: () async {
                                              item.liveLink!.contains('http')
                                                  ? await launchUrl(Uri.parse(
                                                      'https://' +
                                                          item.liveLink!))
                                                  : await launchUrl(Uri.parse(
                                                      item.liveLink!));
                                            },
                                            child: Align(
                                              alignment: Alignment.bottomRight,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 8),
                                                child: const Text(
                                                  'Join now',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 14,
                                                      color: ColorPlate
                                                          .primaryLightBG),
                                                ),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            48),
                                                    color: ColorPlate.yellow70),
                                              ),
                                            ),
                                          )
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/svg/correct.svg",
                                                width: 14,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              const Text(
                                                'Going',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                    color: ColorPlate
                                                        .primaryLightBG),
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  final Event event = Event(
                                                    title: item.title!,
                                                    description:
                                                        item.description!,
                                                    location: 'Event location',
                                                    startDate: item.startTime!
                                                        .toLocal(),
                                                    endDate:
                                                        item.endTime!.toLocal(),
                                                    iosParams: const IOSParams(
                                                      reminder:
                                                          Duration(hours: 1),
                                                    ),
                                                  );

                                                  Add2Calendar.addEvent2Cal(
                                                      event);
                                                },
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: .5,
                                                            color: ColorPlate
                                                                .primaryLightBG),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(48),
                                                        color:
                                                            Colors.transparent),
                                                    height: 35,
                                                    width: 180,
                                                    child: Center(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
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
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 14,
                                                                color: ColorPlate
                                                                    .primaryLightBG),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
              }),
        ),
      ],
    );
  }
}
