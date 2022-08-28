import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/community/subs/upcoming_evets.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/live_session/livesession_details/live_session_details.dart';

class LiveSessionListItem extends StatelessWidget {
  const LiveSessionListItem({Key? key, required this.event}) : super(key: key);
  final UpcomingEvent event;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigate.push(context, LiveSessionDetailsScreen(item: event.session()));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * .75,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 247, 249, 1),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${event.title}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
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
                  "assets/svg/Calendar_Event 24.svg", height: 16, width: 16,
                ),
                const SizedBox(
                  width: 10,
                ),
                event.dateToString(),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                SvgPicture.asset("assets/svg/Clock 24.svg", height: 16, width: 16,),
                const SizedBox(
                  width: 8,
                ),
                event.timeToString(),
              ],
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              children: [
                Container(
                  height: 16,
                    width: 16,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(180),
                      child: Image.network(
                        event.host!.profileImage ?? "",
                        height: 16,
                        width: 16,
                        errorBuilder: (context, error, child){
                          return const Center(
                            child: Icon(Icons.image_not_supported_sharp, size: 15,),
                          );
                        },
                         )),
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
                      '${event.host?.firstName} ${event.host?.lastName}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: ColorPlate.secondaryLightBG),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}