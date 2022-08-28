import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

class CompleteProfileCard extends StatelessWidget {
  const CompleteProfileCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.done,
      required this.onAdd})
      : super(key: key);
  final String icon;
  final String title;
  final bool done;
  final Function onAdd;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 175,
      width: 175,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            height: 30,
            width: 30,
            color: Colors.black,
          ),
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
          const SizedBox(),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: done
                ? const Icon(
                    Icons.check_circle,
                    color: Color(0xFF18AA79),
                    size: 30,
                  )
                : ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
                elevation: MaterialStateProperty.all(0)
              ),
                    onPressed: () {
                      onAdd();
                    },
                    child: const Text("Add", style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),)),
          ),
        ],
      ),
    );
  }
}
