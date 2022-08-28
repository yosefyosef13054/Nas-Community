import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/trainer/meet_trainer_api.dart';
import 'package:nas_academy/core/modules/common/host.dart';
import 'package:nas_academy/core/modules/community/active_community/active_community.dart';
import 'package:nas_academy/core/modules/trainer_booking/trainer_booking.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/booking_card/trainer_booking_card.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/calendly_view/calendly_view.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/components/trainer_badge.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/members_details_screen.dart';
import 'package:provider/provider.dart';

class MeetAnExpert extends StatefulWidget {
  const MeetAnExpert({Key? key, this.pop, required this.community})
      : super(key: key);
  final bool? pop;
  final ActiveCommunity community;

  @override
  State<MeetAnExpert> createState() => _MeetAnExpertState();
}

class _MeetAnExpertState extends State<MeetAnExpert> {

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        leading: widget.pop == true
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
      ),
      body: FutureBuilder<TrainerBooking>(
        future: TrainerAPI().fetchLatestBooking(widget.community.id!),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            if (snapshot.data!.status == "active"){
              final TrainerBooking booking = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Meet an Expert",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Book a slot with one of our expert trainers",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorPlate.secondaryLightBG),
                        ),
                        TrainerBookingCard(booking: booking, host: Host(profileImage: widget.community.trainer!.profileImage, firstName: widget.community.trainer!.firstName, lastName: widget.community.trainer!.lastName)),
                        const SizedBox(
                          height: 35,
                        ),
                        ListTile(
                          onTap: () {
                            Navigate.push(context, MemberDetailsScreen(member: widget.community.trainer!, booked: true,));
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "${widget.community.trainer!.firstName} ${widget.community.trainer!.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          subtitle: const TrainerBadge(),
                          trailing: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all(ColorPlate.tertiaryLightBG),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                            ),
                            onPressed: null,
                            child: const Text("Booked"),
                          ),
                          leading: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(widget.community.trainer!.profileImage!),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ],
                ),
              );

            }else {
              return Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Meet an Expert",
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Book a slot with one of our expert trainers",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorPlate.secondaryLightBG),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        ListTile(
                          onTap: () {
                            Navigate.push(context,
                                MemberDetailsScreen(member: widget.community.trainer!, booked: false,));
                          },
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            "${widget.community.trainer!.firstName} ${widget.community.trainer!.lastName}",
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                          ),
                          subtitle: const TrainerBadge(),
                          trailing: OutlinedButton(
                            style: ButtonStyle(
                              foregroundColor:
                              MaterialStateProperty.all(ColorPlate.primaryLightBG),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50))),
                            ),
                            onPressed: () => Navigate.push(
                                context, CalendlyView(back: false,trainer: widget.community.trainer!, communityId: widget.community.id!, refresh: (){setState((){});},)),
                            child: const Text("Book a time"),
                          ),
                          leading: Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(widget.community.trainer!.profileImage!),
                                  fit: BoxFit.cover,
                                )),
                          ),
                        ),
                        Container(),
                      ],
                    ),
                  ],
                ),
              );
            }
          }else {
            return const Loading(color: Colors.transparent,);
          }
        }
      ),
    );
  }
}
