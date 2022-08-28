import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/contenful/contentful.dart';
import 'package:nas_academy/core/modules/discover/discover.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/discover/discover.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/discover/community_page/community_page.dart';
import 'package:nas_academy/ui/dash/discover/community_page/why_join_community_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_contentful/client.dart' as c;
import 'dart:developer';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';



class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {

  final RefreshController _refreshController = RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final user = Provider.of<User?>(context);
    final discover = Provider.of<DiscoverProvider>(context);
    final application = Provider.of<ApplicationProvider>(context);
    return Scaffold(
      backgroundColor: ColorPlate.neutral100,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        leading: IconButton(
          icon: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          onPressed: () {
            dash.drawerController.toggle!();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 1),
          child: Visibility(
            visible: application.loading,
            child: const LinearProgressIndicator(
              minHeight: 1.5,
              backgroundColor: Colors.transparent,
              valueColor:
              AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
            ),
          ),
        ),
      ),
      body: SmartRefresher(
        enablePullDown: true,
        controller: _refreshController,
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        header: const RefreshHeader(),
        onRefresh: ()async{
          await application.refresh(dash);
          _refreshController.refreshCompleted(resetFooterState: true);
        },
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.all(25),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  user?.learner.firstName != null ? 'Welcome, ${user?.learner.firstName}' : "Welcome",
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      // height: 144,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: ColorPlate.yellow70
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Why Join\nCommunities?",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),),
                          const SizedBox(height: 5,),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.white),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                                  elevation: MaterialStateProperty.all(0)
                              ),
                              onPressed: (){
                                Navigate.push(context, const WhyJoinCommunityPage());
                              }, child: const Text("Learn more")),
                        ],
                      ),
                    ),
                    Positioned(
                      right: -25,
                      top: 20,
                      child: SvgPicture.asset(Assets.whyJoinMenu, height: 130, width: 130,),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("Choose a community", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),),
                const SizedBox(height: 20,),
                FutureBuilder<List<Hit>>(
                    future: discover.getDiscover(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        return GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 200,
                                    childAspectRatio: 3 / 4.5,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext ctx, index) {
                              Hit item = snapshot.data![index];
                              return Stack(
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      if(!application.loading){
                                        final repo = EventRepository(c.Client(
                                          c.BearerTokenHTTPClient(
                                              'WabJrLMKPY2Gkwm1ha9XYV8sd6ZZiM_HDc8Xa2gZ7dY'
                                          ),
                                          spaceId: 'yv8ba1cqjg8q',
                                        ));
                                        try {
                                          application.setLoading = true;
                                          final event = await repo.findBySlug(item.link.toString());
                                          await application.initProducts(event);
                                          await application.getStatusList();
                                          application.setLoading = false;
                                          Navigate.push(context, CommunityPage(items: event));
                                        } catch (e) {
                                          application.setLoading = false;
                                          log('erooooor' + e.toString());
                                        }
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              height : 95,
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(12),
                                                child: Image.network(
                                                  item.discoveryPageImageData.toString(),
                                                  loadingBuilder: (context, child, progress) {
                                                    if ((progress != null && progress.cumulativeBytesLoaded < progress.expectedTotalBytes!)) {
                                                      return Shimmer.fromColors(
                                                        child: Container(
                                                          height: 95,
                                                          color: Colors.grey[300]!,
                                                        ),
                                                        highlightColor: Colors.white,
                                                        baseColor: Colors.grey[200]!,
                                                      );
                                                    } else {
                                                      return child;
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 35,
                                            ),
                                            Text(
                                              item.title.toString(),
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                  color: ColorPlate.primaryLightBG),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              item.by.toString(),
                                              maxLines: 2,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: ColorPlate.primaryLightBG),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              item.discoveryPageDescription.toString(),
                                              maxLines: 3,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 12,
                                                  color: ColorPlate.secondaryLightBG),
                                            ),
                                          ]),
                                      decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(15)),
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    left: 16,
                                    child: SizedBox(
                                      height: 56,
                                      width: 56,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(180),
                                        child: Image.network(
                                          item.discoveryPageCreatorImageData,
                                          height: 56,
                                          width: 56,
                                          loadingBuilder: (context, child, progress) {
                                            if ((progress != null && progress.cumulativeBytesLoaded < progress.expectedTotalBytes!)) {
                                              return Shimmer.fromColors(
                                                child: Container(
                                                  width: 56,
                                                  height: 56,
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey[500]!,
                                                      shape: BoxShape.circle
                                                  ),
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
                                    ),
                                  ),
                                ],
                              );
                            });
                      } else {
                        return const SizedBox(
                          height: 200,
                          child: Center(
                            child: Loading(
                              color: Colors.transparent,
                            ),
                          ),
                        );
                      }
                    }),
              ],
            ),
            application.loading? const Loading() : const SizedBox()
          ],
        ),
      ),
    );
  }
}



class RefreshHeader extends StatelessWidget {
  const RefreshHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomHeader(
      builder: (BuildContext context,RefreshStatus? mode){
        Widget body ;
        switch (mode){
          case RefreshStatus.completed : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.check, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Done", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.idle : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.arrow_downward, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Pull down to refresh", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.canRefresh : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.refresh, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Release to refresh", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG),),
            ],
          );
          break;
          case RefreshStatus.canTwoLevel : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.refresh, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Can Two Level", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.failed : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.error, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Failed Refreshing", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.refreshing : body = Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CupertinoActivityIndicator(),
              SizedBox(width: 10,),
              Text("Refreshing ...", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.twoLevelClosing : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.refresh, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Two Level Closing", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.twoLeveling : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CupertinoActivityIndicator(color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Two Leveling ... ", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case RefreshStatus.twoLevelOpening : body =  Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.refresh, color: ColorPlate.tertiaryLightBG,),
              SizedBox(width: 10,),
              Text("Two Level Opening", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG)),
            ],
          );
          break;
          case null : body =  const Text("Pull down to refresh", style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: ColorPlate.tertiaryLightBG));
          break;
        }
        return SizedBox(
          height: 55.0,
          child: Center(child:body),
        );
      },
    );
  }
}

