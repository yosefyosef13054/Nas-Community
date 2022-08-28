import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/static_lists.dart';
import 'package:provider/provider.dart';


class SkillsFiltersBody extends StatefulWidget {
  const SkillsFiltersBody({Key? key}) : super(key: key);

  @override
  State<SkillsFiltersBody> createState() => _SkillsFiltersBodyState();
}

class _SkillsFiltersBodyState extends State<SkillsFiltersBody> {
  List<String> _skills = StaticList.skills;
  String _query = "";

  @override
  Widget build(BuildContext context) {
    final membersProvider = Provider.of<MembersProvider>(context);
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          leading: IconButton(
              onPressed: () => membersProvider.setFiltersIndex = 0,
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: Colors.black,
              )),
          title: const Text(
            "Skills",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          actions: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: membersProvider.skills.isNotEmpty ? TextButton(
                child: const Text("Reset"),
                onPressed: (){
                  membersProvider.skills.clear();
                  membersProvider.notify();
                },
              ) : const SizedBox(),
            ),
            const SizedBox(width: 10,),

          ],
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
                              if(val.isNotEmpty){
                                _skills = StaticList.skills.where((element) => element.toLowerCase().replaceAll(" ", "").contains(_query)).toList();
                              }else {
                                _skills = StaticList.skills;
                              }
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
        body: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemCount: _skills.length,
          itemBuilder: (context, index) {
            return SkillFilterBodyListItem(title: _skills[index]);
          },
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.grey[400]!,
                offset: const Offset(0, 1),
                blurRadius: 1,
                blurStyle: BlurStyle.outer,
                spreadRadius: 2)
          ]),
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 40, top: 16, left: 24, right: 24),
            child: SizedBox(
              height: 45,
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                    foregroundColor: MaterialStateProperty.all(membersProvider.skills.isNotEmpty? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),
                    backgroundColor:
                    MaterialStateProperty.all(membersProvider.skills.isNotEmpty? ColorPlate.yellow70 : const Color(0xFFE1E2E5))),
                child: const Text("Show results"),
                onPressed: membersProvider.skills.isNotEmpty? (){
                  membersProvider.applyFilters(context);
                } : null,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SkillFilterBodyListItem extends StatelessWidget {
  const SkillFilterBodyListItem({Key? key, required this.title})
      : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    final selected = members.skills.contains(title);
    return ListTile(
      onTap: () {
        if (selected) {
          members.skills.remove(title);
        } else {
          members.skills.add(title);
        }
        members.notify();
      },
      leading: Checkbox(
        value: selected,
        fillColor: MaterialStateProperty.all(ColorPlate.primaryLightBG),
        onChanged: (val) {
          if (selected) {
            members.skills.remove(title);
          } else {
            members.skills.add(title);
          }
          members.notify();
        },
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
    );
  }
}