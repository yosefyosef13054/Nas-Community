import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/api/edit_profile/skills_and_interests.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:provider/provider.dart';


class AddSkillsBottomSheet extends StatefulWidget {
  const AddSkillsBottomSheet({Key? key}) : super(key: key);

  @override
  State<AddSkillsBottomSheet> createState() => _AddSkillsBottomSheetState();
}

class _AddSkillsBottomSheetState extends State<AddSkillsBottomSheet> {
  String _query = "";
  bool _match (String val){
    if(_query.isEmpty){
      return true;
    }else {
      return val.toLowerCase().replaceAll(" ", "").contains(_query.toLowerCase().replaceAll(" ", ""));
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.black,
              )),
          centerTitle: true,
          title: const Text(
            "Add skill",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 70),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.search,
                          color: ColorPlate.tertiaryLightBG,
                          size: 18,
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: TextFormField(
                          onChanged: (val){
                            setState((){
                              _query = val.toLowerCase().replaceAll(" ", "");
                            });
                          },
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              hintText: "Search for a skill",
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: ColorPlate.tertiaryLightBG)),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 10,),
                  const Divider()
                ],
              ),
            ),
          ),
        ),
        body: FutureBuilder<List<String>>(
          future: const SkillsAPI().getSkills(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              final List<String> items = snapshot.data!.where((element) => _match(element)).toList();
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return SkillListItem(title: items[index]);
                },
              );
            }else {
              return const Loading(color: Colors.transparent,);
            }
          }
        ),
      ),
    );
  }
}

class SkillListItem extends StatelessWidget {
  const SkillListItem({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    final profile = Provider.of<ProfileProvider>(context);
    final selected =  profile.skills.contains(title);
    return ListTile(
      onTap: () {
        if (selected) {
          profile.skills.remove(title);
        } else {
          profile.skills.add(title);
        }
        profile.setSkillsToShow = (user?.learner.skills ?? []) + profile.skills;
        profile.notify();
      },
      leading: Checkbox(
        value: selected,
        fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
        onChanged: (val) {
          if (selected) {
            profile.skills.remove(title);
          } else {
            profile.skills.add(title);
          }
          profile.notify();
        },
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}