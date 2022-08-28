import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';

class MainFiltersBody extends StatelessWidget {
  const MainFiltersBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(28),
            topRight: Radius.circular(28),
          ),
          color: Colors.white),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25, top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filters",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.close,
                      size: 22,
                      color: ColorPlate.neutral70,
                    ))
              ],
            ),
          ),
          const Divider(
            height: 0,
            color: ColorPlate.neutral70,
          ),
          FilterListTile(
            title: "Member Role",
            index: 1,
            selected: members.memberRole || members.managerRole,
            subtitle: Row(
              children: [
                Visibility(
                  visible: members.memberRole,
                  child: SelectedFilterItem(
                      title: "Member",
                      remove: () => members.setMemberRole = false),
                ),
                Visibility(
                  visible: members.managerRole,
                  child: SelectedFilterItem(
                      title: "Community Manager",
                      remove: () => members.setManagerRole = false),
                ),
              ],
            ),
          ),
          FilterListTile(
            title: "Locations",
            index: 2,
            selected: members.countries.isNotEmpty,
            subtitle: members.countries.length > 2
                ? SelectedFilterItem(
                    remove: () {
                      members.countries.clear();
                      members.notify();
                    },
                    title:
                        "${members.countries.first} and ${members.countries.length - 1} more")
                : Row(
                    children: members.countries
                        .map((e) => SelectedFilterItem(
                            remove: () {
                              members.countries.remove(e);
                              members.notify();
                            },
                            title: e))
                        .toList(),
                  ),
          ),
          FilterListTile(
            title: "Skills",
            index: 3,
            selected: members.skills.isNotEmpty,
            subtitle: members.skills.length > 2
                ? SelectedFilterItem(
                remove: () {
                  members.skills.clear();
                  members.notify();
                },
                title:
                "${members.skills.first} and ${members.skills.length - 1} more")
                : Row(
              children: members.skills
                  .map((e) => SelectedFilterItem(
                  remove: () {
                    members.skills.remove(e);
                    members.notify();
                  },
                  title: e))
                  .toList(),
            ),
          ),
          FilterListTile(
            title: "Social platforms",
            index: 4,
            selected: members.socialPlatform.isNotEmpty,
            subtitle: members.socialPlatform.length > 2
                ? SelectedFilterItem(
                remove: () {
                  members.socialPlatform.clear();
                  members.notify();
                },
                title:
                "${members.socialPlatform.first} and ${members.socialPlatform.length - 1} more")
                : Row(
              children: members.socialPlatform
                  .map((e) => SelectedFilterItem(
                  remove: () {
                    members.socialPlatform.remove(e);
                    members.notify();
                  },
                  title: e))
                  .toList(),
            ),
          ),
          FilterListTile(
            title: "Follower count",
            index: 5,
            selected: members.followersCount != null,
            subtitle: SelectedFilterItem(
              title: members.followersCount.toString(),
              remove: ()=> members.setFollowersCount = null,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          const Divider(height: 0, color: ColorPlate.neutral90),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 40, top: 16, left: 24, right: 24),
            child: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: SizedBox(
                      height: 45,
                      child: OutlinedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(48))),
                            foregroundColor: MaterialStateProperty.all(
                                ColorPlate.primaryLightBG),
                          ),
                          onPressed: () {members.resetFilters();},
                          child: const Text("Reset")),
                    )),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 45,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
                          foregroundColor: MaterialStateProperty.all(members.valid()? ColorPlate.primaryLightBG : ColorPlate.tertiaryLightBG),
                          backgroundColor:
                          MaterialStateProperty.all(members.valid()? ColorPlate.yellow70 : const Color(0xFFE1E2E5))),
                      child: const Text("Show results"),
                      onPressed: members.valid()? (){
                        members.applyFilters(context);
                      } : null,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FilterListTile extends StatelessWidget {
  const FilterListTile(
      {Key? key,
      required this.title,
      required this.index,
      required this.subtitle,
      required this.selected})
      : super(key: key);
  final String title;
  final int index;
  final Widget subtitle;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      onTap: () => members.setFiltersIndex = index,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 14),
                ),
                Text(
                  selected ? "Edit" : "Any",
                  style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: ColorPlate.secondaryLightBG),
                )
              ],
            ),
            Visibility(visible: selected, child: Padding(
              padding: const EdgeInsets.only(top: 15, bottom: 5),
              child: subtitle,
            )),
            const SizedBox(
              height: 20,
            ),
            const Divider(
              height: 0,
              color: ColorPlate.neutral70,
            ),
          ],
        ),
      ),
    );
  }
}

class SelectedFilterItem extends StatelessWidget {
  const SelectedFilterItem(
      {Key? key, required this.remove, required this.title})
      : super(key: key);
  final String title;
  final Function remove;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: ColorPlate.blurple60,
          ),
        ),
        const SizedBox(
          width: 3,
        ),
        InkWell(
          borderRadius: BorderRadius.circular(180),
          onTap: () {
            remove();
          },
          child: const Padding(
            padding: EdgeInsets.all(3.0),
            child: Icon(
              Icons.close,
              color: ColorPlate.blurple60,
              size: 18,
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
      ],
    );
  }
}


