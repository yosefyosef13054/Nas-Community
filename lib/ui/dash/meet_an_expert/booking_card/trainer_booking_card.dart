import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/community/subs/upcoming_evets.dart';
import 'package:nas_academy/core/modules/trainer_booking/trainer_booking.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/booking_details_screen/booking_details_screen.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/calendly_view/edit_booking_view.dart';

class TrainerBookingCard extends StatefulWidget {
  const TrainerBookingCard(
      {Key? key, required this.booking, required this.host})
      : super(key: key);
  final TrainerBooking booking;
  final Host host;

  @override
  State<TrainerBookingCard> createState() => _TrainerBookingCardState();
}

class _TrainerBookingCardState extends State<TrainerBookingCard> {
  @override
  Widget build(BuildContext context) {
    if (widget.booking.status != "NONE") {
      final String day = DateFormat('EE').format(widget.booking.startTime!);
      final String date = DateFormat('d').format(widget.booking.startTime!);
      String fullDate =
          DateFormat('EEEE, d MMMM').format(widget.booking.startTime!);
      String startTimeHour = DateFormat.jm().format(widget.booking.startTime!);
      String endTimeHour = DateFormat.jm().format(widget.booking.endTime!);
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Upcoming",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            monthAsString(widget.booking.startTime!.month),
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(day,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: ColorPlate.secondaryLightBG)),
                    Text(
                      date,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 20),
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              Expanded(
                flex: 8,
                child: InkWell(
                  onTap: () {
                    Navigate.push(
                        context,
                        BookingDetails(
                          booking: widget.booking,
                          host: widget.host,
                        ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: ColorPlate.neutral95,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "1-on-1 with ${widget.host.firstName} ${widget.host.lastName}",
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
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
                              borderRadius: BorderRadius.circular(25),
                              child: Image.network(
                                widget.host.profileImage.toString(),
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
                                  'Meeting with',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: ColorPlate.secondaryLightBG),
                                ),
                                Text(
                                  "${widget.host.firstName} ${widget.host.lastName}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: ColorPlate.secondaryLightBG),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Divider(
                          color: ColorPlate.tertiaryLightBG,
                          height: 0,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 30,
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        ColorPlate.primaryLightBG),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(48)))),
                                label: const Text("Edit"),
                                icon: const Icon(
                                  Icons.edit,
                                  size: 17,
                                ),
                                onPressed: () {
                                  Navigate.push(
                                      context,
                                      EditBookingView(
                                          back: false,
                                          refresh: () {
                                            setState(() {});
                                          },
                                          rescheduleLink:
                                              widget.booking.rescheduleLink!,
                                          communityId:
                                              widget.booking.communityId!,
                                          host: widget.host));
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SizedBox(
                              height: 30,
                              child: OutlinedButton.icon(
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all(
                                        ColorPlate.primaryLightBG),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(48)))),
                                label: const Text("Add to calendar"),
                                icon: SvgPicture.asset(
                                  "assets/svg/Calendar_Event 16.svg",
                                  height: 16,
                                  width: 16,
                                ),
                                onPressed: () {
                                  final Event event = Event(
                                    title:
                                        "1-on-1 with ${widget.host.firstName} ${widget.host.lastName}",
                                    // description: item.description!,
                                    location: 'Event location',
                                    startDate:
                                        widget.booking.startTime!.toLocal(),
                                    endDate: widget.booking.endTime!.toLocal(),
                                    iosParams: const IOSParams(
                                      reminder: Duration(hours: 1),
                                    ),
                                  );

                                  Add2Calendar.addEvent2Cal(event);
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          const Divider(
            height: 0,
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      );
    } else {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
  }
}
