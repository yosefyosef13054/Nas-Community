import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/todo/components/todo_screen_body.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ToDoScreen extends StatefulWidget {
  const ToDoScreen({Key? key, this.pop}) : super(key: key);
  final bool? pop;

  @override
  State<ToDoScreen> createState() => _ToDoScreenState();
}

class _ToDoScreenState extends State<ToDoScreen>
    with SingleTickerProviderStateMixin {
  late TodoProvider _toDo;
  late ScrollController _scrollController;
  late Future future;

  @override
  void initState() {
    super.initState();
    _toDo = Provider.of<TodoProvider>(context, listen: false);
    // future = _toDo.init();
    _toDo.setTabController = TabController(length: 4, vsync: this);
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
    _toDo.tabController.dispose();
    _scrollController.dispose();
  }

  double titlePadding = 24;
  double appBarSize = 200;
  bool collapsed = false;

  @override
  Widget build(BuildContext context) {
    final toDo = Provider.of<TodoProvider>(context);
    return ChangeNotifierProvider<MembersProvider>(
      create: (context) => MembersProvider(),
      child:
          Consumer<MembersProvider>(builder: (context, membersProvider, child) {
        return Scaffold(
          backgroundColor: ColorPlate.neutral100,
          body: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              controller: _scrollController,
              slivers: [
                SliverLayoutBuilder(builder: (context, constraint) {
                  final bool showTitle = constraint.scrollOffset < 180 ||
                      (constraint.userScrollDirection ==
                              ScrollDirection.forward &&
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
                                color: ColorPlate.light50),
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
                      duration: const Duration(milliseconds: 100),
                      child: showTitle
                          ? const SizedBox()
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/svg/progress_image.svg",
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 16,
                                    ),
                                    const Text(
                                      'Get Started',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  barRadius: const Radius.circular(170),
                                  backgroundColor: ColorPlate.neutral90,
                                  animation: false,
                                  lineHeight: 6,
                                  percent: toDo.todoTasks.isEmpty? 0 :((toDo.getfinishedtodoTasksID.length.toDouble() / toDo.todoTasks.length.toDouble()) * 1),
                                  animateFromLastPercent: false,
                                  progressColor: Colors.green,
                                ),
                              ],
                            ),
                    ),
                    foregroundColor: ColorPlate.primaryLightBG,
                    systemOverlayStyle: SystemUiOverlayStyle.dark,
                    expandedHeight: 250,
                    elevation: 1,
                    collapsedHeight: 70,
                    automaticallyImplyLeading: false,
                    flexibleSpace: FlexibleSpaceBar(
                      titlePadding: EdgeInsets.only(bottom: 0, left: titlePadding),
                      expandedTitleScale: 1,
                      background: Padding(
                        padding: const EdgeInsets.only(left: 24.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: SvgPicture.asset(
                                "assets/svg/progress_image.svg",
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Get started",
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const SizedBox(
                              width: 260,
                              child: Text(
                                'Explore all the features in your new community',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: ColorPlate.secondaryLightBG),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            LinearPercentIndicator(
                              padding: const EdgeInsets.only(right: 25),
                              barRadius: const Radius.circular(170),
                              backgroundColor: ColorPlate.neutral90,
                              animation: true,
                              lineHeight: 8,
                              percent:  toDo.todoTasks.isEmpty? 0 :((toDo.getfinishedtodoTasksID.length.toDouble() / toDo.todoTasks.length.toDouble()) * 1),
                              animateFromLastPercent: true,
                              progressColor: Colors.green,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 24),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "${toDo.getfinishedtodoTasksID.length} of ${toDo.gettodoTasks.length} completed",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: ColorPlate.tertiaryDarkBG,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    ConstrainedBox(
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height -
                                60 -
                                MediaQuery.of(context).padding.top +
                                5),
                        child: const TodoScreenBody()),
                  ]),
                ),
              ]),
        );
      }),
    );
  }
}
