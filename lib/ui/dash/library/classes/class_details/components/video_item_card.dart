import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/library/class/video_item.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/video_stream/video_player.dart';
import 'package:nas_academy/ui/dash/library/resources/components/share_bottom_sheet.dart';
import 'package:shimmer/shimmer.dart';

class VideoItemCard extends StatelessWidget {
  const VideoItemCard({Key? key, required this.video}) : super(key: key);
  final VideoItem video;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()async{
        final String cookie = await UserLocalDB.getCookie();
        final headers =  {'cookie': cookie};
        Navigate.push(context, VideoStreamPlayer(shortLink: video.shortUrl, headers: headers, hlsLink: video.hlsLink!,));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: FutureBuilder<String>(
                        future: UserLocalDB.getCookie(),
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            final headers =  {'cookie': snapshot.data!};
                            return Image.network(
                              video.thumbnail ?? "",
                              height: 64,
                              width: 64,
                              headers: headers,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, val){
                                return Container(
                                  width: 64,
                                  height: 64,
                                  color: Colors.grey[200]!,
                                  child: const Center(
                                    child: Icon(LineIcons.image, size: 20, ),
                                  ),
                                );
                              },
                              loadingBuilder: (context, child, progress){
                                if(progress != null && progress.cumulativeBytesLoaded > progress.expectedTotalBytes!){
                                  return Shimmer.fromColors(
                                    child: Container(
                                      width: 64,
                                      height: 64,
                                      color: Colors.grey[300]!,),
                                    highlightColor: Colors.white,
                                    baseColor: Colors.grey[300]!,
                                  );
                                }else {
                                  return child;
                                }
                              },
                            );
                          }else {
                            return Shimmer.fromColors(
                              child: Container(
                                width: 64,
                                height: 64,
                                color: Colors.grey[300]!,),
                              highlightColor: Colors.white,
                              baseColor: Colors.grey[300]!,
                            );
                          }
                        }
                    ),
                  ),
                ),
                const SizedBox(width: 10,),
                Expanded(
                  flex: 6,
                  child: Center(child: Text(video.title ?? "", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),)),
                ),
                const SizedBox(width: 10,),
                const Expanded(
                  flex: 1,
                  child: SizedBox()
                ),
              ],
            ),
            Visibility(
              visible: video.shortUrl != null || video.link != null ,
              child: Positioned(
                top: 0,
                right: -10,
                child: InkWell(
                  onTap: (){
                    showBarModalBottomSheet(
                      expand: false,
                      context: context,
                      duration: const Duration(milliseconds: 300),
                      animationCurve: Curves.easeInOut,
                      backgroundColor: Colors.transparent,
                      builder: (ctx) {
                        return  ShareBottomSheet(link: video.shortUrl ?? video.link ?? "", title: video.topic,);
                      },
                    );
                  },
                  child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(LineIcons.verticalEllipsis, color: ColorPlate.tertiaryLightBG, size: 28,)),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
