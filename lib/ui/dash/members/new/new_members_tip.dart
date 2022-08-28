import 'package:flutter/material.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/utils/color_plate.dart';



class NewMembersTip extends StatefulWidget {
  const NewMembersTip({Key? key}) : super(key: key);

  @override
  State<NewMembersTip> createState() => _NewMembersTipState();
}

class _NewMembersTipState extends State<NewMembersTip> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      initialData: false,
      future: UserLocalDB.getSayHiToNewMembers(),
      builder: (context, snapshot) {
        return AnimatedSwitcher(
            duration: const Duration(milliseconds: 0),
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
                  const Text(
                    "Say hi to new members",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: ColorPlate.secondaryLightBG),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "See members who just joined the community!",
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
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                          elevation: MaterialStateProperty.all(0)
                      ),
                      onPressed: () => setState(() {
                        UserLocalDB.setSayHiToNewMembers(false);
                      }),
                      child: const Text("Got it")),
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
}
