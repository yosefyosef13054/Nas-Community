import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/todo/todo_main.dart';
import 'package:provider/provider.dart';

class TodoDashView extends StatelessWidget {
  const TodoDashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final todo = Provider.of<TodoProvider>(context);
    final dash = Provider.of<DashProvider>(context);
    return FutureBuilder<bool>(
        initialData: true,
        future: UserLocalDB.getOriantationShowp(),
        builder: (context, snapshot) {
          return AnimatedSize(
            duration: const Duration(milliseconds: 250),
            child: snapshot.data == false ||
                    todo.todoTasks.isEmpty ||
                    todo.getfinishedtodoTasksID.length == todo.todoTasks.length
                ? Container(height: 20, color: Colors.white)
                : Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    decoration: const BoxDecoration(color: ColorPlate.yellow95),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, color: ColorPlate.yellow95),
                        Row(children: [
                          SvgPicture.asset(
                            "assets/svg/progress_image.svg",
                            height: 48,
                            width: 48,
                          ),
                          const Spacer(),
                          PopupMenuButton<String>(
                            icon: const Icon(Icons.more_vert),
                            elevation: 2,
                            color: Colors.grey[50],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            onSelected: (val) {
                              if (val == "Not now") {
                                UserLocalDB.setOriantationShow(false);
                                dash.notify();
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                const PopupMenuItem<String>(
                                  height: 32,
                                  child: Text("Not now",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14)),
                                  value: "Not now",
                                )
                              ];
                            },
                          ),
                        ]),
                        const SizedBox(
                          height: 14,
                        ),
                        const Text(
                          'Get started',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.grey[300],
                            minHeight: 8,
                            value: todo.todoTasks.isEmpty
                                ? 0
                                : ((todo.getfinishedtodoTasksID.length
                                            .toDouble() /
                                        todo.todoTasks.length.toDouble()) *
                                    1),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.green),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Navigate.push(
                                context,
                                const ToDoScreen(
                                  pop: true,
                                ));
                          },
                          child: Container(
                            width: 148,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(48)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  'View progress',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: Colors.white),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 15,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
          );
        });
  }
}
