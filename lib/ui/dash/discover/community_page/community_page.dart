import "package:flutter/material.dart";
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/application/application_status.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/about_section.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/community_members_section.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/apply_button.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/exclusive_space_section.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/got_questions_section.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/payment_section.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/whats_inside_section.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({required this.items, Key? key}) : super(key: key);
  final List<Item> items;

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    final List<ApplicationStatus> status = application.statusList.where((element) => element.communityCode == widget.items.first.fields?.communityCode).toList();
    return Scaffold(
      backgroundColor: ColorPlate.primaryDarkBG,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverLayoutBuilder(builder: (context, constraint) {
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
                        shape: BoxShape.circle,
                        color: ColorPlate.light50,
                      ),
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
                          Expanded(
                            flex: 5,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * .5,
                              child: Text(
                                widget.items[0].fields!.bannerSection!
                                    .communityTitle
                                    .toString(),
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ApplyButton(
                                width: 130,
                                height: 35,
                                status: status.isNotEmpty
                                    ? status.last.communitySubscriptionStatus
                                    : null,
                                community: widget.items.first,
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
              bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 10),
                child: Visibility(
                  visible: application.loading,
                  child: const LinearProgressIndicator(
                    minHeight: 1.5,
                    backgroundColor: Colors.white,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
                  ),
                ),
              ),
              foregroundColor: ColorPlate.primaryLightBG,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              expandedHeight: 250,
              elevation: 1,
              collapsedHeight: 70,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.zero,
                expandedTitleScale: 1,
                background: Stack(
                  fit: StackFit.expand,
                  alignment: Alignment.topLeft,
                  children: [
                    Hero(
                      tag: "${widget.items[0].fields?.bannerSection?.fullScreenBannerImgData?.mobileImgProps.src}",
                      child: Image.network(
                        widget.items[0].fields?.bannerSection?.fullScreenBannerImgData?.mobileImgProps.src ?? "",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, child){
                          return Container(
                            color: ColorPlate.neutral90,
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 50, color: ColorPlate.tertiaryLightBG,),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, progress) {
                          if (progress != null &&
                              progress.cumulativeBytesLoaded <
                                  progress.expectedTotalBytes!) {
                            return Shimmer.fromColors(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 500,
                                color: Colors.grey[500]!,
                              ),
                              highlightColor: Colors.white,
                              baseColor: Colors.grey[300]!,
                            );
                          } else {
                            return child;
                          }
                        },
                      ),
                    ),
                    Positioned(
                      bottom: -5,
                      child: Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20),
                          ),
                          color: ColorPlate.primaryDarkBG,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 15,
                      left: 15,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Colors.white,
                          ),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * .03,
                            vertical: 0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(widget
                              .items[0]
                              .fields!
                              .descriptionSection!
                              .imageSection
                              .imgData!
                              .mobileImgProps
                              .src
                              .toString()),
                          radius: 50,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          SliverList(
            delegate: SliverChildListDelegate.fixed(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        widget.items[0].fields!.bannerSection!.communityTitle.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: ColorPlate.primaryLightBG,
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Hosted By ',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                color: ColorPlate.neutral10,
                              ),
                            ),
                            TextSpan(
                              text: widget
                                  .items[0].fields!.bannerSection!.hostedBy
                                  .toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorPlate.neutral0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      ApplyButton(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        status: status.isNotEmpty
                            ? status.last.communitySubscriptionStatus
                            : null,
                        community: widget.items.first,
                      ),
                      const SizedBox(
                        height: 38,
                      ),
                      AboutSection(items: widget.items),
                      const SizedBox(
                        height: 38,
                      ),
                      WhatsInsideSection(items: widget.items),
                      const SizedBox(
                        height: 38,
                      ),
                      CommunityMembersSection(items: widget.items),
                      const SizedBox(
                        height: 38,
                      ),
                      PaymentSection(
                          community: widget.items.first,
                          status: status.isNotEmpty
                              ? status.last.communitySubscriptionStatus
                              : null),
                      const SizedBox(
                        height: 38,
                      ),
                      ExclusiveSpaceSection(items: widget.items),
                      const SizedBox(
                        height: 38,
                      ),
                      GotQuestionsSection(items: widget.items),
                      const SizedBox(
                        height: 38,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
