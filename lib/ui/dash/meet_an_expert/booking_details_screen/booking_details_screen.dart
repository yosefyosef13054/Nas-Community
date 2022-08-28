import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/trainer_booking/trainer_booking.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/calendly_view/cancel_event_view.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/calendly_view/edit_booking_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingDetails extends StatefulWidget {
  const BookingDetails({Key? key, required this.booking, required this.host})
      : super(key: key);
  final TrainerBooking booking;
  final Host host;

  @override
  State<BookingDetails> createState() => _BookingDetailsState();
}

class _BookingDetailsState extends State<BookingDetails> {
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    String fullDate =
        DateFormat('EEEE, d MMMM').format(widget.booking.startTime!);
    String startTimeHour = DateFormat.jm().format(widget.booking.startTime!);
    String endTimeHour = DateFormat.jm().format(widget.booking.endTime!);
    return Scaffold(
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
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child: Visibility(
            visible: dash.loading,
            child: const LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(25),
        children: [
          Text(
            "1-on-1 with ${widget.host.firstName} ${widget.host.lastName}",
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
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
                            "Shown in your timezone: ${DateTime.now().timeZoneName} (GMT${DateTime.now().timeZoneOffset.inHours.isNegative ? "" : "+"}${DateTime.now().timeZoneOffset.inHours})",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 14)),
                        value: "Not now",
                      )
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'On Zoom',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorPlate.primaryLightBG),
                  ),
                  InkWell(
                    onTap: () async {
                      await launchUrl(Uri.parse("https://zoom.us/download"));
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Need to install Zoom?',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorPlate.secondaryLightBG),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Find it here',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: ColorPlate.secondaryLightBG),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 18,
          ),
          const Divider(),
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Divider(),
          TextButton(
            child: Text(
              "Cancel meeting",
              style: TextStyle(
                  fontWeight: FontWeight.w600, color: Colors.red[900]!),
            ),
            onPressed: () {
              Navigate.push(
                  context,
                  CancelBookingView(
                    cancelLink: widget.booking.cancelLink!,
                    communityId: widget.booking.communityId!,
                    host: widget.host,
                    back: true,
                    refresh: () {
                      setState(() {});
                    },
                  ));
            },
          ),
          // const SizedBox(height: 5,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(ColorPlate.primaryLightBG),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48)))),
                child: const Text("Reschedule meeting"),
                onPressed: () {
                  Navigate.push(
                      context,
                      EditBookingView(
                        rescheduleLink: widget.booking.rescheduleLink!,
                        communityId: widget.booking.communityId!,
                        back: true,
                        host: widget.host,
                        refresh: () {
                          setState(() {});
                        },
                      ));
                },
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: OutlinedButton.icon(
                style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all(ColorPlate.primaryLightBG),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(48)))),
                label: const Text("Add to calendar"),
                onPressed: () {
                  final Event event = Event(
                    title:
                        "1-on-1 with ${widget.host.firstName} ${widget.host.lastName}",
                    // description: item.description!,
                    location: 'Event location',
                    startDate: widget.booking.startTime!.toLocal(),
                    endDate: widget.booking.endTime!.toLocal(),
                    iosParams: const IOSParams(
                      reminder: Duration(hours: 1),
                    ),
                  );

                  Add2Calendar.addEvent2Cal(event);
                },
                icon: SvgPicture.asset(
                  "assets/svg/Calendar_Event 16.svg",
                  height: 16,
                  width: 16,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
