import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/library_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/library/classes/classes.dart';
import 'package:nas_academy/ui/dash/library/resources/resources.dart';
import 'package:provider/provider.dart';



class Library extends StatelessWidget {
  const Library({Key? key, required this.pop}) : super(key: key);
  final bool? pop;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LibraryProvider>(
        create: (context)=> LibraryProvider(),
        child: LibraryContent(pop: pop,));
  }
}



class LibraryContent extends StatefulWidget {
  const LibraryContent({Key? key, this.pop}) : super(key: key);
  final bool? pop;

  @override
  State<LibraryContent> createState() => _LibraryContentState();
}

class _LibraryContentState extends State<LibraryContent> with SingleTickerProviderStateMixin {
  late LibraryProvider _libraryProvider;
  late ScrollController _scrollController;
  late Future future;

  @override
  void initState() {
    super.initState();
    _libraryProvider = Provider.of<LibraryProvider>(context, listen: false);
    _libraryProvider.setTabController = TabController(length: 2, vsync: this);
    final dash = Provider.of<DashProvider>(context, listen: false);
    future = dash.initLibrary();
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
    _libraryProvider.tabController.dispose();
  }

  double titlePadding = 24;
  double appBarSize = 200;
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Scaffold(
      backgroundColor: ColorPlate.primaryDarkBG,
      body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              pinned: true,
              forceElevated: true,
              primary: true,
              systemOverlayStyle: SystemUiOverlayStyle.dark,
              backgroundColor: ColorPlate.primaryDarkBG,
              elevation: 1,
              centerTitle: false,
              leading: widget.pop == true
                  ? IconButton(
                splashRadius: 25,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 18,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
                  : IconButton(
                splashRadius: 25,
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  dash.drawerController.toggle!();
                },
              ),
              collapsedHeight: 65,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                title: const Text(
                  "Library",
                  style: TextStyle(color: Colors.black),
                ),
                titlePadding: EdgeInsets.only(bottom: 70, left: titlePadding),
                expandedTitleScale: 1.5,
              ),
              bottom: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 45),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: 250,
                    child: TabBar(
                      overlayColor: MaterialStateProperty.all(Colors.transparent),
                      indicatorColor: Colors.black,
                      controller: _libraryProvider.tabController,
                      labelColor: Colors.black,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelColor: Colors.grey[800]!,
                      onTap: (index) => setState(() {}),
                      tabs: const [
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Tab(text: "Classes", )),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Tab(text: "Resources", )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate.fixed([
                LibraryBody(
                  future: future,
                )
              ]),
            ),
          ]),
    );
  }
}




class LibraryBody extends StatelessWidget {
  const LibraryBody({
    Key? key,
    required this.future,
  }) : super(key: key);
  final Future future;

  @override
  Widget build(BuildContext context) {
    final _libraryProvider = Provider.of<LibraryProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - 65 - MediaQuery.of(context).padding.top - 45),
      child: FutureBuilder(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              switch (_libraryProvider.tabController.index){
                case 0 : return const ClassTab();
                case 1 : return const ResourcesTab();
                default : return const ClassTab();
              }
            } else {
              return const Center(
                child: Loading(
                  color: Colors.transparent,
                ),
              );
            }
          }),
    );
  }
}
