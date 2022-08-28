import 'package:flick_video_player/flick_video_player.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/services/share.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:video_player/video_player.dart';

class VideoStreamPlayer extends StatefulWidget {
  const VideoStreamPlayer(
      {Key? key, required this.hlsLink, required this.headers, this.shortLink})
      : super(key: key);
  final String hlsLink;
  final Map<String, String> headers;
  final String? shortLink;

  @override
  State<VideoStreamPlayer> createState() => _VideoStreamPlayerState();
}

class _VideoStreamPlayerState extends State<VideoStreamPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(
        widget.hlsLink,
        httpHeaders: widget.headers,
        formatHint: VideoFormat.hls,
      ),
      autoInitialize: true,
      autoPlay: true,
    );
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          widget.shortLink != null? IconButton(
            iconSize: 40,
            onPressed: () {
              ShareHandler.shareLink(
                  link: widget.shortLink!);
            },
            icon: SvgPicture.asset(
              "assets/svg/Share.svg",
              height: 40,
              width: 40,
            ),
          ) : const SizedBox(),
        ],
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            height: 40,
            width: 40,
            padding: const EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: ColorPlate.light50),
            child: const Center(
              child: Icon(
                Icons.arrow_back_ios,
                size: 18,
                color: ColorPlate.primaryLightBG,
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: FlickVideoPlayer(
              flickManager: flickManager,
            ),
          ),

        ],
      ),
    );
  }
}

// Visibility(
// visible: flickManager.flickControlManager?.isFullscreen != true,
// child: Padding(
// padding: const EdgeInsets.all(25.0),
// child: Text(
// widget.video.title ?? "",
// style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
// ),
// ),
// ),
//
//
//
// class VideoStreamPlayer extends StatefulWidget {
//   const VideoStreamPlayer(
//       {Key? key, required this.video, required this.headers})
//       : super(key: key);
//   final VideoItem video;
//   final Map<String, String> headers;
//
//   @override
//   State<VideoStreamPlayer> createState() => _VideoStreamPlayerState();
// }
//
// class _VideoStreamPlayerState extends State<VideoStreamPlayer> {
//   late VideoPlayerController _controller;
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(widget.video.link!,
//         httpHeaders: widget.headers)
//       ..initialize().then((_) {
//         setState(() {});
//         _controller.play();
//         _controller.setVolume(100);
//       });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
//   bool _showControl = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         systemOverlayStyle: SystemUiOverlayStyle.dark,
//         actions: [
//           IconButton(
//             iconSize: 40,
//             onPressed: () {
//               ShareHandler.shareLink(
//                   link: widget.video.shortUrl!, title: widget.video.title);
//             },
//             icon: SvgPicture.asset(
//               "assets/svg/Share.svg",
//               height: 40,
//               width: 40,
//             ),
//           ),
//         ],
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: Container(
//             height: 40,
//             width: 40,
//             padding: const EdgeInsets.only(left: 5),
//             decoration: BoxDecoration(
//                 shape: BoxShape.circle, color: ColorPlate.light50),
//             child: const Center(
//               child: Icon(
//                 Icons.arrow_back_ios,
//                 size: 18,
//                 color: ColorPlate.primaryLightBG,
//               ),
//             ),
//           ),
//         ),
//         bottom: PreferredSize(
//           preferredSize: Size(MediaQuery.of(context).size.width, 1),
//           child: Visibility(
//             visible: !_controller.value.isInitialized,
//             child: const LinearProgressIndicator(
//               minHeight: 1.5,
//               backgroundColor: Colors.white,
//               valueColor: AlwaysStoppedAnimation<Color>(ColorPlate.yellow70),
//             ),
//           ),
//         ),
//       ),
//       body: ListView(
//         children: [
//           Center(
//             // alignment: Alignment.topCenter,
//             child: AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: Stack(
//                 children: [
//                   InkWell(
//                       onTap: ()async{
//                         if(_showControl){
//                           setState((){_showControl = false;});
//                         }else {
//                           setState((){_showControl = true;});
//                           await Future.delayed(const Duration(seconds: 4));
//                           setState((){_showControl = false;});
//                         }
//                       },
//                       child: VideoPlayer(_controller)),
//                   _controller.value.isBuffering
//                       ? const Loading(
//                           color: Colors.black54,
//                         )
//                       : const SizedBox(
//                           height: 0,
//                           width: 0,
//                         ),
//                   _showControl? VideoControls(controller: _controller) : const SizedBox(height: 0, width: 0,),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(25.0),
//             child: Text(
//               widget.video.title ?? "",
//               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class VideoControls extends StatefulWidget {
//   const VideoControls({Key? key, required this.controller}) : super(key: key);
//   final VideoPlayerController controller;
//
//   @override
//   State<VideoControls> createState() => _VideoControlsState();
// }
//
// class _VideoControlsState extends State<VideoControls>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//
//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 200));
//     widget.controller.addListener(() {
//       setState(() {});
//     });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _animationController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.black54,
//       height: 500,
//       width: double.infinity,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           const SizedBox(
//             height: 0,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               IconButton(
//                   onPressed: () {
//                     widget.controller.seekTo(Duration(
//                         seconds:
//                             widget.controller.value.position.inSeconds - 10));
//                   },
//                   icon: SvgPicture.asset(
//                     "assets/svg/reverse.svg",
//                     color: Colors.white,
//                     height: 40,
//                     width: 40,
//                   )),
//               IconButton(
//                   onPressed: () {
//                     if (widget.controller.value.isPlaying) {
//                       _animationController.forward();
//                       widget.controller.pause();
//                     } else {
//                       _animationController.reverse();
//                       widget.controller.play();
//                     }
//                   },
//                   icon: AnimatedIcon(
//                     icon: AnimatedIcons.pause_play,
//                     progress: _animationController,
//                     color: Colors.white,
//                     size: 40,
//                   )),
//               IconButton(
//                   onPressed: () {
//                     widget.controller.seekTo(Duration(
//                         seconds:
//                             widget.controller.value.position.inSeconds + 10));
//                   },
//                   icon: SvgPicture.asset(
//                     "assets/svg/forward.svg",
//                     color: Colors.white,
//                     height: 40,
//                     width: 40,
//                   )),
//             ],
//           ),
//           Row(
//             children: [
//               Text(
//                 "${TimeFormatter.durationInMSToTime(widget.controller.value.position.inMilliseconds)}/${TimeFormatter.durationInMSToTime(widget.controller.value.duration.inMilliseconds)}",
//                 style: const TextStyle(
//                     fontWeight: FontWeight.w500,
//                     fontSize: 12,
//                     color: Colors.white),
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
