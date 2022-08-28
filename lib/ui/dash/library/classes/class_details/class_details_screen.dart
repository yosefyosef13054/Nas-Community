import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/library/class/video.dart';
import 'package:nas_academy/core/providers/dash/library_provider.dart';
import 'package:nas_academy/core/services/share.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/components/header.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/components/resources_tab.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/components/vid_resources_tab_bar.dart';
import 'package:nas_academy/ui/dash/library/classes/class_details/components/videos_tab.dart';
import 'package:provider/provider.dart';

class ClassDetailsScreen extends StatefulWidget {
  const ClassDetailsScreen({Key? key, required this.videoClass})
      : super(key: key);
  final VideoClass videoClass;

  @override
  State<ClassDetailsScreen> createState() => _ClassDetailsScreenState();
}

class _ClassDetailsScreenState extends State<ClassDetailsScreen> {
  late LibraryProvider _lib;

  @override
  void initState() {
    super.initState();
    _lib = Provider.of<LibraryProvider>(context, listen: false);
  }

  @override
  void dispose() {
    super.dispose();
    _lib.setClassDetailsIndexSilent = 0;

  }

  @override
  Widget build(BuildContext context) {
    final lib = Provider.of<LibraryProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverLayoutBuilder(builder: (context, constraint) {
              final bool showTitle = constraint.scrollOffset < 200 ||
                  (constraint.userScrollDirection == ScrollDirection.forward &&
                      constraint.scrollOffset < 350);
              return SliverAppBar(
                toolbarHeight: 65,
                backgroundColor: Colors.white,
                pinned: true,
                actions: [
                  IconButton(
                    iconSize: 40,
                    onPressed: () {
                      ShareHandler.shareLink(
                          link: widget.videoClass.preview!.thumbnail!,
                          title: widget.videoClass.preview?.topic);
                    },
                    icon: SvgPicture.asset(
                      "assets/svg/Share.svg",
                      height: 40,
                      width: 40,
                    ),
                  ),
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
                                flex: 1,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      widget.videoClass.preview?.thumbnail ??
                                          ""),
                                )),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                                flex: 4,
                                child: Text(
                                  widget.videoClass.preview?.topic ?? "",
                                  maxLines: 3,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14),
                                )),
                          ],
                        ),
                ),
                foregroundColor: ColorPlate.primaryLightBG,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                expandedHeight: 350,
                elevation: 0,
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
                      color: Colors.white,
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                  expandedTitleScale: 1,
                  background: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.topLeft,
                    children: [
                      Hero(
                        tag: "${widget.videoClass.topicIndex}",
                        child: Image.network(
                          widget.videoClass.preview?.thumbnail ?? "",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            SliverToBoxAdapter(
              child: VideoClassDetailsHeader(videoClass: widget.videoClass),
            ),
            SliverVisibility(
              visible: widget.videoClass.resource != null &&
                  widget.videoClass.resource!.items.isNotEmpty,
              sliver: SliverLayoutBuilder(builder: (context, constraint) {
                final bool showTitle = constraint.scrollOffset > 0 ||
                    (constraint.userScrollDirection == ScrollDirection.reverse);
                return SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  primary: false,
                  floating: false,
                  automaticallyImplyLeading: false,
                  collapsedHeight: 0,
                  toolbarHeight: 0,
                  expandedHeight: 0,
                  elevation: 1,
                  forceElevated: false,
                  foregroundColor: Colors.black,
                  bottom: PreferredSize(
                    preferredSize: Size(MediaQuery.of(context).size.width, 60),
                    child: Padding(
                      padding: EdgeInsets.only(top: showTitle ? 0 : 10),
                      child:
                          VideoResourcesTabBar(videoClass: widget.videoClass),
                    ),
                  ),
                );
              }),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                Container(
                  color: ColorPlate.neutral95,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height -
                              70 -
                              MediaQuery.of(context).padding.top -
                              (widget.videoClass.resource != null &&
                                      widget
                                          .videoClass.resource!.items.isNotEmpty
                                  ? 60
                                  : -5)),
                      child: Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: Builder(
                          builder: (context) {
                            if (lib.classDetailsIndex == 0) {
                              return VideosTab(videoClass: widget.videoClass);
                            } else if (lib.classDetailsIndex == 1) {
                              return VideoResourcesTab(
                                  videoClass: widget.videoClass);
                            } else {
                              return VideosTab(videoClass: widget.videoClass);
                            }
                          },
                        ),
                      )),
                ),
              ]),
            ),
          ],
        ));
  }
}
