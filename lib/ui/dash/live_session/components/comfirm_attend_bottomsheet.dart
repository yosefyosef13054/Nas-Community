import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

import 'package:nas_academy/ui/dash/live_session/livesession_details/live_session_details.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ConfirmAttendingSheet extends StatelessWidget {
  ConfirmAttendingSheet(
      {required this.item, this.isfromDetailsScreen, Key? key})
      : super(key: key);
  final Session item;
  bool? isfromDetailsScreen = false;

  // var differenceMinuts = item.startTime!.difference(DateTime.now()).inMinutes;

  @override
  Widget build(BuildContext context) {
    final liveSessionProvider = Provider.of<LiveSessonProvider>(context);
    String fullDate =
        DateFormat('EEEE, d MMMM').format(item.startTime!.toLocal());
    String startTimeHour = DateFormat.jm().format(item.startTime!.toLocal());
    String endTimeHour = DateFormat.jm().format(item.endTime!.toLocal());
    return Material(
        color: ColorPlate.neutral100,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Container(
                margin: const EdgeInsets.only(left: 24, bottom: 24),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      const Text(
                        'Confirm your attendance',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 25),
                          child: const Icon(
                            Icons.close,
                            color: ColorPlate.neutral70,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: ColorPlate.neutral95),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24),
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
                    const SizedBox(
                      height: 32,
                    ),
                    InkWell(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(right: 24),
                          height: 48,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () async {
                              liveSessionProvider.confirmAttendance(
                                  context, item);
                            },
                            style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(48)))),
                            child: const Center(
                              child: Text(
                                'Confirm',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: ColorPlate.primaryLightBG),
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(48),
                              color: ColorPlate.yellow70),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    isfromDetailsScreen == true
                        ? InkWell(
                            onTap: () {
                              Navigate.push(
                                  context,
                                  LiveSessionDetailsScreen(
                                    item: item,
                                  ),
                                  offset: const Offset(
                                    1,
                                    0,
                                  ));
                            },
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                margin: const EdgeInsets.only(right: 24),
                                height: 48,
                                width: double.infinity,
                                child: const Center(
                                  child: Text(
                                    'Session details',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: ColorPlate.primaryLightBG),
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: .5,
                                        color: ColorPlate.primaryLightBG),
                                    borderRadius: BorderRadius.circular(48),
                                    color: ColorPlate.neutral100),
                              ),
                            ),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.only(right: 24),
                              height: 48,
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty
                                        .resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                        if (states
                                            .contains(MaterialState.pressed)) {
                                          return Colors.white;
                                        }
                                        return Colors.white;
                                      },
                                    ),
                                    elevation: MaterialStateProperty.all(0),
                                    padding: MaterialStateProperty.all(
                                        EdgeInsets.zero),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(48)))),
                                child: const Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: ColorPlate.primaryLightBG),
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: .5,
                                      color: ColorPlate.primaryLightBG),
                                  borderRadius: BorderRadius.circular(48),
                                  color: ColorPlate.neutral100),
                            ),
                          ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ));
  }
}
