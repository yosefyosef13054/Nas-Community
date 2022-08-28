import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/community/subs/subscription.dart';
import 'package:nas_academy/core/modules/community/subs/upcoming_evets.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:provider/provider.dart';


class CommunitiesMemberDetails extends StatelessWidget {
  const CommunitiesMemberDetails({Key? key, required this.list}) : super(key: key);
  final List<Subscription> list;
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Visibility(
      visible: list.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Communities",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: list.map((sub) => ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(dash.communities.elementAt(dash.communitiesIndex).thumbnailImgData!.mobileImageData!.src!),
              ),
              title:  Text((sub.communityCode ?? "").replaceAll("_", " "), style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
              subtitle: Row(
                children: [
                  const Text("Member", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),),
                  const SizedBox(width: 5,),
                  Text("since ${DateTime.parse(sub.createdAt!).day} ${monthAsString(DateTime.parse(sub.createdAt!).month)} ${DateTime.parse(sub.createdAt!).year}", style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                ],
              ),
            ),).toList(),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}


