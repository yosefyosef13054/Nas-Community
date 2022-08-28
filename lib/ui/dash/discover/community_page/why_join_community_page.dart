import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class WhyJoinCommunityPage extends StatelessWidget {
  const WhyJoinCommunityPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPlate.primaryDarkBG,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverLayoutBuilder(
            builder: (context, constraint) {
              final bool showTitle = constraint.scrollOffset < 200 ||
                  (constraint.userScrollDirection == ScrollDirection.forward &&
                      constraint.scrollOffset < 350);
              return SliverAppBar(
                toolbarHeight: 65,
                backgroundColor: ColorPlate.primaryDarkBG,
                pinned: true,
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
                            shape: BoxShape.circle, color: ColorPlate.light50),
                        child: const Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 4.0),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
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
                            const Text(
                              'Why join communities',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 14),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  primary: ColorPlate.yellow70,
                                  shape: const StadiumBorder()),
                              onPressed: () {
                                Navigator.pop(context);                              },
                              child: const Text('Join Now'),
                            ),
                          ],
                        ),
                ),
                foregroundColor: ColorPlate.primaryLightBG,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                expandedHeight: 158,
                elevation: 1,
                collapsedHeight: 70,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  background: Column(
                    children: const [
                      SizedBox(
                        height: 88,
                      ),
                      Text(
                        'Why join communities?',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: ColorPlate.primaryLightBG,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(24.0),
                  children: [
                    const WhyJoinCommunityCard(
                      title: 'Report an incident or a member',
                      text:
                          'Collaboratee with other content creators and get the opportunity to meet successful creators like Warren Carlyle, Parth Vijayvergiya, and Natasha Billson and many more who are already members.',
                      image: Assets.whyJoinCommunityFirst,
                    ),
                    const WhyJoinCommunityCard(
                      title: 'Access to curated learning content',
                      text:
                          'Get free access to some of the most popular Nas Academy classes, resources, and other exclusive content to upskill and improve your strategies.',
                      image: Assets.whyJoinCommunitySecond,
                    ),
                    const WhyJoinCommunityCard(
                      title: 'Support From Community Managers',
                      text:
                          'If you ever have questions or need guidance in your creator journey, you have instant access to a knowledgeable group of instructors, facilitators, and other members who are just a message away.',
                      image: Assets.whyJoinCommunityThird,
                    ),
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, shape: const StadiumBorder()),
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'Find a community',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: ColorPlate.primaryLightBG,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WhyJoinCommunityCard extends StatelessWidget {
  final String title;
  final String text;
  final String image;
  const WhyJoinCommunityCard({
    Key? key,
    required this.title,
    required this.text,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: ColorPlate.primaryLightBG,
          ),
        ),
        const SizedBox(
          height: 14,
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: ColorPlate.neutral40,
          ),
        ),
        Image.asset(image),
        const SizedBox(
          height: 64,
        ),
      ],
    );
  }
}
