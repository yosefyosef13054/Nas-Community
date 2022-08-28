import 'package:flutter/material.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/community/subs/community_video.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/time_formatter.dart';
import 'package:nas_academy/ui/common/logo.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/video_stream/video_player.dart';
import 'package:shimmer/shimmer.dart';

class CommunityVideoCard extends StatefulWidget {
  const CommunityVideoCard({Key? key, required this.video}) : super(key: key);
  final CommunityVideo video;

  @override
  State<CommunityVideoCard> createState() => _CommunityVideoCardState();
}

class _CommunityVideoCardState extends State<CommunityVideoCard> {
  late Future<String> future;
    @override
    void initState() {
      super.initState();
      future = UserLocalDB.getCookie();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: FutureBuilder<String>(
          future: future,
          builder: (context, snapshot) {
            if(snapshot.hasData && snapshot.data != null){
              final headers = {'cookie': snapshot.data!};
              return InkWell(
                onTap: () {
                  if(widget.video.hlsLink != null){
                    Navigate.push(
                        context,
                        VideoStreamPlayer(
                            hlsLink: widget.video.hlsLink!, headers: headers));
                  }
                },
                child: SizedBox(
                  height: 280,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 3,
                          child: Stack(
                            children: [
                              ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(10),
                                      topRight: Radius.circular(10)),
                                  child: Image.network(
                                    widget.video.thumbnail!,
                                    headers: headers,
                                    fit: BoxFit.cover,
                                    width: 5000,
                                    height: 5000,
                                    loadingBuilder: (context, child, progress) {
                                      if ((progress != null && progress.cumulativeBytesLoaded < progress.expectedTotalBytes!)) {
                                        return Shimmer.fromColors(
                                          child: Container(
                                            width:
                                            MediaQuery.of(context).size.width,
                                            height: 5000,
                                            color: Colors.grey[500]!,
                                          ),
                                          highlightColor: Colors.white,
                                          baseColor: Colors.grey[300]!,
                                        );
                                      } else {
                                        return child;
                                      }
                                    },
                                    errorBuilder: (context, obj, error) {
                                      return Container(
                                        width: MediaQuery.of(context).size.width,
                                        color: ColorPlate.neutral90,
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported_sharp,
                                            size: 60,
                                          ),
                                        ),
                                      );
                                    },
                                  )),
                              const Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Logo(width: 30, height: 30),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 20,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.black87,
                                    ),
                                    child: Text(
                                      TimeFormatter.durationInMSToTime(
                                          widget.video.duration!),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 10,
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: ColorPlate.neutral95,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      widget.video.topic ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    height: 48,
                                    width: 48,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorPlate.yellow70),
                                    child: const Center(
                                      child: Icon(
                                        Icons.play_arrow,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }else {
              return SizedBox(
                height: 280,
                width: MediaQuery.of(context).size.width * 0.9,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Stack(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                                child: Shimmer.fromColors(
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width,
                                    height: 5000,
                                    color: Colors.grey[500]!,
                                  ),
                                  highlightColor: Colors.white,
                                  baseColor: Colors.grey[300]!,
                                )),
                            const Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Logo(width: 30, height: 30),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  height: 20,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.black87,
                                  ),
                                  child: Text(
                                    TimeFormatter.durationInMSToTime(
                                        widget.video.duration!),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 10,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: ColorPlate.neutral95,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Text(
                                    widget.video.topic ?? "",
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: ColorPlate.yellow70),
                                  child: const Center(
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
