import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';

class MemberRoleFiltersBody extends StatelessWidget {
  const MemberRoleFiltersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return ListView(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 5, bottom: 5, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => membersProvider.setFiltersIndex = 0,
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 18,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Member Role",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ],
              ),
              AnimatedOpacity(
                  opacity: membersProvider.memberRole || membersProvider.managerRole? 1 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: TextButton(
                    child: const Text("Reset"),
                    onPressed: (){
                      membersProvider.setMemberRole = false;
                      membersProvider.setManagerRole = false;
                    },
                  ),
              )
            ],
          ),
        ),
        const Divider(
          height: 0,
          color: ColorPlate.neutral70,
        ),
        const SizedBox(
          height: 15,
        ),
        ListTile(
          onTap: ()=>membersProvider.setMemberRole = !membersProvider.memberRole,
            leading: IgnorePointer(
              ignoring: true,
              child: Checkbox(
                fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
                value: membersProvider.memberRole,
                onChanged: (val)=>{},
              ),
            ),
            title: const Text(
              "Member",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )),
        ListTile(
            onTap: ()=>membersProvider.setManagerRole = !membersProvider.managerRole,
            leading: IgnorePointer(
              ignoring: true,
              child: Checkbox(
                fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
                value: membersProvider.managerRole,
                onChanged: (val)=>{},
              ),
            ),
            title: const Text(
              "Community Manager",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
            )),
        const SizedBox(
          height: 20,
        ),
        const Divider(height: 0, color: ColorPlate.neutral90),
        Padding(
          padding:
              const EdgeInsets.only(bottom: 40, top: 16, left: 24, right: 24),
          child: SizedBox(
            height: 45,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                  foregroundColor: MaterialStateProperty.all(membersProvider.memberRole || membersProvider.managerRole? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),
                  backgroundColor:
                      MaterialStateProperty.all(membersProvider.memberRole || membersProvider.managerRole? ColorPlate.yellow70 : const Color(0xFFE1E2E5))),
              child: const Text("Show results"),
              onPressed: membersProvider.memberRole || membersProvider.managerRole? (){
                membersProvider.applyFilters(context);
              } : null,
            ),
          ),
        )
      ],
    );
  }
}
