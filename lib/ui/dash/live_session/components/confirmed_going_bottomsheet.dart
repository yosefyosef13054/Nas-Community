import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/live_session/main_live_sessions.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class ConfirmedAttendanseSheet extends StatefulWidget {
  const ConfirmedAttendanseSheet({required this.item, Key? key})
      : super(key: key);
  final Session item;

  @override
  State<ConfirmedAttendanseSheet> createState() =>
      _ConfirmedAttendanseSheetState();
}

class _ConfirmedAttendanseSheetState extends State<ConfirmedAttendanseSheet> {
  @override
  Widget build(BuildContext context) {

    return Material(
        color: ColorPlate.neutral100,
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 37.33),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/successLogo.png",
                      ),
                      const SizedBox(
                        height: 17,
                      ),
                      const Text(
                        'Confirmed, see you there!',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.white;
                              }
                              return Colors.white;
                            },
                          ),
                          elevation: MaterialStateProperty.all(0),
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(48)))),
                      onPressed: () {
                        final Event event = Event(
                          title: widget.item.title!,
                          description: widget.item.description!,
                          location: 'Event location',
                          startDate: widget.item.startTime!.toLocal(),
                          endDate: widget.item.endTime!.toLocal(),
                          iosParams: const IOSParams(
                            reminder: Duration(hours: 1),
                          ),
                        );

                        Add2Calendar.addEvent2Cal(event);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: const EdgeInsets.only(right: 24),
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
                              color: ColorPlate.neutral100),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      margin: const EdgeInsets.only(right: 24),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.white;
                                }
                                return Colors.white;
                              },
                            ),
                            elevation: MaterialStateProperty.all(0),
                            padding: MaterialStateProperty.all(EdgeInsets.zero),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(48)))),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 48,
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                'Done',
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
