import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/services/permission_handler.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class NearMeTip extends StatefulWidget {
  const NearMeTip({Key? key}) : super(key: key);

  @override
  State<NearMeTip> createState() => _NearMeTipState();
}

class _NearMeTipState extends State<NearMeTip> with AutomaticKeepAliveClientMixin{


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<bool>(
      initialData: false,
      future: UserLocalDB.getShowNearMeMembersTip(),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            reverseDuration: const Duration(milliseconds: 300),
            transitionBuilder: (child, animation) {
              return SizeTransition(
                axis: Axis.vertical,
                sizeFactor: animation,
                child: child,
              );
            },
            child: snapshot.data == true
                ? Container(
                    color: ColorPlate.neutral95,
                    padding: const EdgeInsets.all(25),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SvgPicture.asset("assets/svg/near_me.svg"),
                            PopupMenuButton<String>(
                              elevation: 2,
                              color: Colors.grey[50],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              onSelected: (val) {
                                if (val == "Not now") {
                                  setState(() {
                                    UserLocalDB.setShowNearMeMembersTip(false);
                                    UserLocalDB.setNearMeTipShowsNumber();
                                  });
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  const PopupMenuItem<String>(
                                    height: 32,
                                    child: Text("Not now",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14)),
                                    value: "Not now",
                                  )
                                ];
                              },
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Find members who are near you based on your location. Plan meet ups or collaborate with them!",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: ColorPlate.secondaryLightBG),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(48))),
                                elevation: MaterialStateProperty.all(0)),
                            onPressed: ()async{
                              final bool granted =  await PermissionHandlerService.locationRequest(context);
                              if(granted){
                                setState(() {
                                  UserLocalDB.setShowNearMeMembersTip(false);
                                });
                              }
                              },
                            child: const Text("Let’s go")),
                      ],
                    ),
                  )
                : const SizedBox(
                    height: 0,
                    width: 0,
                  ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
