import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/member/followers_range.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class FollowersCountFiltersBody extends StatelessWidget {
  const FollowersCountFiltersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        toolbarHeight: 70,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
            onPressed: () => membersProvider.setFiltersIndex = 0,
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Colors.black,
            )),
        title: const Text(
          "Total follower count",
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16,color: Colors.black,),
        ),
        actions: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: membersProvider.followersCount != null ? TextButton(
              child: const Text("Reset"),
              onPressed: (){
                membersProvider.setFollowersCount = null;
              },
            ) : const SizedBox(),
          ),
          const SizedBox(width: 10,),

        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: _ranges.length,
        itemBuilder: (context, index){
          return FollowersCountFilterListTileItem(range: _ranges[index]);
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey[400]!,
                  offset: const Offset(0,1),
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                  spreadRadius: 2
              )
            ]
        ),
        child: Padding(
          padding:
          const EdgeInsets.only(bottom: 40, top: 16, left: 24, right: 24),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                  foregroundColor: MaterialStateProperty.all(membersProvider.followersCount != null? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),
                  backgroundColor:
                  MaterialStateProperty.all(membersProvider.followersCount != null? ColorPlate.yellow70 : const Color(0xFFE1E2E5))),
              child: const Text("Show results"),
              onPressed: membersProvider.followersCount != null? (){
                membersProvider.applyFilters(context);
              } : null,
            ),
          ),
        ),
      ),
    );
  }
}



class FollowersCountFilterListTileItem extends StatelessWidget {
  const FollowersCountFilterListTileItem({Key? key, required this.range}) : super(key: key);
  final FollowersRange range;
  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    final bool selected = members.followersCount != null && members.followersCount!.id == range.id;
    return  ListTile(
        onTap: (){
          if(selected){
            members.setFollowersCount = null;
          }else {
            members.setFollowersCount = range;
          }
        },
        leading: IgnorePointer(
          ignoring: true,
          child: Checkbox(
            fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
            value: selected,
            onChanged: (val){},
          ),
        ),
        title: Text(
          range.toString(),
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
        ));
  }
}




List<FollowersRange> _ranges = [
  FollowersRange(min: 1, max: 10000, id: const Uuid().v4()),
  FollowersRange(min: 10000, max: 50000, id: const Uuid().v4()),
  FollowersRange(min: 50000, max: 100000, id: const Uuid().v4()),
  FollowersRange(min: 100000, max: 500000, id: const Uuid().v4()),
  FollowersRange(min: 500000, max: 1000000, id: const Uuid().v4()),
  FollowersRange(min: 1000000, max: 5000000, id: const Uuid().v4()),
  FollowersRange(min: 10000000, max: 10000000, id: const Uuid().v4()),
];