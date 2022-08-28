import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/library_provider.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/class_details_screen.dart';
import 'package:nas_academy/ui/dash/library/classes/components/new_badge.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class ClassCard extends StatelessWidget {
  const ClassCard({Key? key, required this.videoClass}) : super(key: key);
  final VideoClass videoClass;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final lib = Provider.of<LibraryProvider>(context);
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onTap: () {
        if (dash.libraryClasses.isNotEmpty) {
          Navigator.push(
              context,
              PageRouteBuilder(
                  transitionsBuilder: (context, a1, a2, child) {
                    return FadeTransition(
                      opacity: a1,
                      child: FadeTransition(opacity: a1, child: child),
                    );
                  },
                  pageBuilder: (_, __, ___) =>
                      ChangeNotifierProvider<LibraryProvider>.value(
                          value: lib,
                          child: ClassDetailsScreen(
                            videoClass: videoClass,
                          ))));
        }
      },
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            height: 250,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey[200],
            ),
            child: Hero(
              tag: "${videoClass.topicIndex}",
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FutureBuilder<String>(
                    future: UserLocalDB.getCookie(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final headers = {'cookie': snapshot.data!};
                        return Image.network(
                          videoClass.preview?.thumbnail ?? "",
                          headers: headers,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return Shimmer.fromColors(
                          child: Container(
                            color: Colors.grey[300]!,
                          ),
                          highlightColor: Colors.white,
                          baseColor: Colors.grey[300]!,
                        );
                      }
                    }),
              ),
            ),
          ),
          Container(
            height: 250,
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                    begin: Alignment.topCenter, end: Alignment.bottomCenter,
                    // stops: [0.1,0.2, 0.3, ],
                    colors: [Colors.black54, Colors.transparent])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Text(
                        videoClass.topic ?? "",
                        maxLines: 3,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: InkWell(
                          onTap: () {},
                          child: const Icon(
                            LineIcons.verticalEllipsis,
                            color: Colors.white,
                            size: 28,
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    LibraryNewBadge(visible: videoClass.preview?.isNew == true),
                    Text(
                      "${videoClass.preview?.videoCount}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.white),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SvgPicture.asset(
                      "assets/svg/video_lib.svg",
                      color: Colors.white,
                    ),
                    Visibility(
                      visible: videoClass.resource?.items.isNotEmpty == true,
                      child: Container(
                        height: 24,
                        margin: const EdgeInsets.symmetric(horizontal: 9),
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 7),
                        child: Row(
                          children: [
                            Text(
                              "${videoClass.resource?.items.length}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            SvgPicture.asset(
                              "assets/svg/collections_bookmark.svg",
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
