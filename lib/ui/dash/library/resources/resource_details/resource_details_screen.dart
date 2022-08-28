import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nas_academy/core/modules/library/resource/video_resource.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/library/resources/resource_details/components/resource_item_card.dart';

class ResourceDetailsScreen extends StatefulWidget {
  const ResourceDetailsScreen({Key? key,required this.resource,})
      : super(key: key);
  final VideoResource resource;

  @override
  State<ResourceDetailsScreen> createState() => _ResourceDetailsScreenState();
}

class _ResourceDetailsScreenState extends State<ResourceDetailsScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset < 90 && _scrollController.offset > 40) {
        setState(() {
          titlePadding = (_scrollController.offset / 1.6).round().toDouble();
        });
      }
      if (_scrollController.offset > 90 && titlePadding != 55) {
        setState(() {
          titlePadding = 55;
        });
      }
      if (_scrollController.offset < 40 && titlePadding != 25) {
        setState(() {
          titlePadding = 25;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  double titlePadding = 24;
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: false,
      backgroundColor: Colors.white,
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              elevation: 1,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios,
                    size: 18, color: ColorPlate.primaryLightBG),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    "assets/svg/Share.svg",
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
              ],
              pinned: true,
              primary: true,
              collapsedHeight: 65,
              expandedHeight: 150,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: Text(
                  widget.resource.topic ?? "",
                  style: const TextStyle(color: Colors.black),
                ),
                titlePadding: EdgeInsets.only(bottom: 23, left: titlePadding, top: 23),
                expandedTitleScale: 1.3,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - 55),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: widget.resource.items
                          .map((e) => ResourceItemCard(item: e, color: ColorPlate.neutral97,))
                          .toList(),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
    );
  }
}