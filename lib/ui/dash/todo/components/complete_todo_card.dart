import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/todo/todo.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/todo/components/todo_bottom_sheet.dart';

class CompletedTodoCard extends StatelessWidget {
  const CompletedTodoCard({Key? key, required this.item}) : super(key: key);
  final Todo item;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showBarModalBottomSheet(
        expand: false,
        context: context,
        duration: const Duration(milliseconds: 300),
        animationCurve: Curves.easeInOut,
        backgroundColor: Colors.transparent,
        builder: (context) => ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(28),
              topRight: Radius.circular(28),
            ),
            child: TodoBottomSheet(
              item: item,
              isFinished: true,
            )),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SvgPicture.asset(
                "assets/svg/finished.svg",
                width: 24,
                height: 24,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              flex: 10,
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: ColorPlate.neutral97,
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SvgPicture.network(
                        item.icon.toString(),
                        height: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title.toString(),
                            maxLines: 2,
                            overflow: TextOverflow.visible,
                            softWrap: true,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
