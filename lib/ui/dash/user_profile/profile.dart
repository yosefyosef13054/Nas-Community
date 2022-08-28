import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/settings/settings_page.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_profile.dart';
import 'package:nas_academy/ui/dash/user_profile/profile/profile_body.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context, listen: true);
    return Scaffold(
        backgroundColor: ColorPlate.primaryDarkBG,
        body: user == null
            ? const Loading(
                color: Colors.transparent,
              )
            : CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverLayoutBuilder(builder: (context, constraint) {
                    final bool showTitle = constraint.scrollOffset < 200 ||
                        (constraint.userScrollDirection ==
                                ScrollDirection.forward &&
                            constraint.scrollOffset < 350);
                    return SliverAppBar(
                      toolbarHeight: 65,
                      backgroundColor: ColorPlate.primaryDarkBG,
                      pinned: true,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Center(
                            child: InkWell(
                              borderRadius: BorderRadius.circular(180),
                              onTap: () {
                                Navigate.push(context, const SettingPage());
                              },
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPlate.light50,
                                ),
                                child:
                                    const Center(child: Icon(Icons.settings)),
                              ),
                            ),
                          ),
                        ),
                      ],
                      leadingWidth: 55,
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Center(
                          child: InkWell(
                            borderRadius: BorderRadius.circular(180),
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorPlate.light50),
                              child: const Center(
                                child: Icon(Icons.close),
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: showTitle
                            ? const SizedBox()
                            : Row(
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        user.learner.profileImage!),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    "${user.learner.firstName} ${user.learner.lastName ?? ''}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14),
                                  ),
                                ],
                              ),
                      ),
                      foregroundColor: ColorPlate.primaryLightBG,
                      systemOverlayStyle: SystemUiOverlayStyle.dark,
                      expandedHeight: 350,
                      elevation: 1,
                      collapsedHeight: 70,
                      automaticallyImplyLeading: false,
                      flexibleSpace: FlexibleSpaceBar(
                        title: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: constraint.scrollOffset < 200 ? 30 : 0,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: ColorPlate.primaryDarkBG,
                          ),
                        ),
                        titlePadding: EdgeInsets.zero,
                        expandedTitleScale: 1,
                        background: Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.topLeft,
                          children: [
                            Image.network(
                              user.learner.profileImage!,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              bottom: 45,
                              right: 15,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100))),
                                  backgroundColor: MaterialStateProperty.all(
                                      ColorPlate.light50),
                                  elevation: MaterialStateProperty.all(0),
                                ),
                                onPressed: () {
                                  Navigate.push(context, EditProfileScreen(
                                    refresh: () {
                                      setState(() {});
                                    },
                                  ));
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 18,
                                ),
                                label: const Text(
                                  "Edit profile",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  SliverList(
                    delegate: SliverChildListDelegate.fixed([
                      ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height -
                                  70 -
                                  MediaQuery.of(context).padding.top +
                                  5),
                          child: UserProfileBody(user: user)),
                    ]),
                  ),
                ],
              ));
  }
}
