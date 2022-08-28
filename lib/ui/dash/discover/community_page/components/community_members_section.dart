import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:url_launcher/url_launcher.dart';

class CommunityMembersSection extends StatelessWidget {
  const CommunityMembersSection({Key? key, required this.items})
      : super(key: key);
  final List<Item> items;
  @override
  Widget build(BuildContext context) {
    return items[0].fields!.members == null
        ? const SizedBox()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Community Members',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                  color: ColorPlate.primaryLightBG,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: ColorPlate.neutral97,
                ),
                width: double.infinity,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: ColorPlate.yellow70, width: 1.5),
                        ),
                        padding: const EdgeInsets.all(2),
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .03,
                            vertical: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width * .3),
                          child: Image.network(
                            items[0]
                                .fields!
                                .members!
                                .cardData!
                                .imgData!
                                .mobileImgProps
                                .src
                                .toString(),
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width * .4,
                            width: MediaQuery.of(context).size.width * .4,
                          ),
                        )),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorPlate.blurple90,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2),
                        child: Text(
                          items[0].fields!.members!.cardData!.role.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: ColorPlate.blurple10,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      items[0].fields!.members!.cardData!.name.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: ColorPlate.primaryLightBG,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Text(
                      items[0].fields!.members!.cardData!.subText.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorPlate.secondaryLightBG,
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    //need to be added
                    GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 200,
                              childAspectRatio: 3 / .7,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 10),
                      itemCount: items[0]
                          .fields!
                          .members!
                          .cardData!
                          .mediaLinks!
                          .length,
                      itemBuilder: (BuildContext ctx, index) {
                        return SocialMediaFollowers(
                            item: items[0]
                                .fields!
                                .members!
                                .cardData!
                                .mediaLinks![index]);
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 42,
              ),
              GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 3,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                itemCount: items[0].fields!.members!.members!.length,
                itemBuilder: (BuildContext ctx, index) {
                  return CommunityMemberProfile(
                      item: items[0].fields!.members!.members![index]);
                },
              )
            ],
          );
  }
}

class SocialMediaFollowers extends StatelessWidget {
  const SocialMediaFollowers({Key? key, required this.item}) : super(key: key);
  final MediaLink item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await launchUrl(Uri.parse(item.link.toString()));
      },
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: OutlinedButton(
          onPressed: null,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: item.type == "facebook" ? SvgPicture.asset(Assets.facebookActive) : item.type == "instagram" ? SvgPicture.asset(Assets.instaActive) :  SvgPicture.network(
                  "https://d2oi1rqwb0pj00.cloudfront.net/nasIO/community-product-page/members-section-v2/${item.type.toString()}.svg",
                  height: 16,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Expanded(
                flex: 5,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    item.text.toString(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: ColorPlate.neutral10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CommunityMemberProfile extends StatelessWidget {
  const CommunityMemberProfile({
    Key? key,
    required this.item,
  }) : super(key: key);
  final Member item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () async {
        // await Auth().logOut(context);
      },
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(shape: BoxShape.circle),
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .03,
                vertical: 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                item.imgData!.mobileImgProps.src.toString(),
                height: MediaQuery.of(context).size.width * .2,
                width: MediaQuery.of(context).size.width * .2,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Center(
            child: Text(
              item.name.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: ColorPlate.primaryLightBG,
              ),
            ),
          ),
          Text(
            item.subText.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: ColorPlate.neutral50,
            ),
          ),
        ],
      ),
    );
  }
}
