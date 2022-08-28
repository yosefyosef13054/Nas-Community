import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:nas_academy/core/providers/dash/library_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';



class VideoResourcesTabBar extends StatefulWidget {
  const VideoResourcesTabBar({Key? key, required this.videoClass}) : super(key: key);
  final VideoClass videoClass;

  @override
  State<VideoResourcesTabBar> createState() => _VideoResourcesTabBarState();
}

class _VideoResourcesTabBarState extends State<VideoResourcesTabBar> with SingleTickerProviderStateMixin{
  late LibraryProvider _libraryProvider;


  @override
  void initState() {
    super.initState();
    _libraryProvider = Provider.of<LibraryProvider>(context, listen: false);
    _libraryProvider.setClassDetailsTabController = TabController(length: 2, vsync: this);
    _libraryProvider.setClassDetailsIndexSilent = 0;
  }


  @override
  void dispose() {
    super.dispose();
    _libraryProvider.classDetailsTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        width: MediaQuery.of(context).size.width * 0.7,
        child: TabBar(
          onTap: (index){
            _libraryProvider.setClassDetailsIndex = index;
          },
          controller: _libraryProvider.classDetailsTabController,
          labelColor: ColorPlate.secondaryLightBG,
          labelStyle: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
          indicatorColor: ColorPlate.secondaryLightBG,
          tabs: const [
            Tab(
              text: "Videos",
            ),
            Tab(
              text: "Resources",
            ),
          ],
        ),
      ),
    );
  }
}
