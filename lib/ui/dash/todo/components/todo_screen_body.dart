import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/todo/todo.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/todo/components/complete_todo_card.dart';
import 'package:nas_academy/ui/dash/todo/components/incomplete_todo_card.dart';
import 'package:provider/provider.dart';

class TodoScreenBody extends StatelessWidget {
  const TodoScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final toDo = Provider.of<TodoProvider>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height -
              65 -
              MediaQuery.of(context).padding.top -
              45),
      child: Column(
        children: [
          const SizedBox(
            height: 28,
          ),
          Visibility(
              visible: toDo.getfinishedtodoTasksID.length ==
                  toDo.gettodoTasks.length,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      flex : 1,
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/svg/tasks_finished.svg",
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Expanded(
                      flex: 7,
                      child: Text(
                        "Great job! You’ve completed all your tasks for the week.",
                        maxLines: 3,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorPlate.tertiaryDarkBG,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          Container(
            color: ColorPlate.neutral100,
            child: ListView.builder(
                padding: const EdgeInsets.all(25),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: toDo.gettodoTasks.length,
                itemBuilder: (context, i) {
                  Todo item = toDo.gettodoTasks[i];
                  return item.completed == true ||
                          toDo.getfinishedtodoTasksID.contains(item.id)
                      ? const SizedBox()
                      : InCompletedTodoCard(item: item);
                }),
          ),
          toDo.getfinishedtodoTasks.isEmpty
              ? const SizedBox()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorPlate.secondaryLightBG),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      color: ColorPlate.neutral100,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: toDo.getfinishedtodoTasks.length,
                          itemBuilder: (context, i) {
                            Todo item = toDo.getfinishedtodoTasks[i];
                            return toDo.getfinishedtodoTasksID
                                        .contains(item.id) !=
                                    true
                                ? const SizedBox()
                                : CompletedTodoCard(item: item);
                          }),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
