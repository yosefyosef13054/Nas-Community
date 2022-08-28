
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TodoListItem extends StatelessWidget {
  const TodoListItem({
    Key? key,
    required this.image,
    required this.text,
  }) : super(key: key);

  final String image;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width * .4,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(246, 247, 249, 1),
          borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                "assets/svg/to_do_$image.svg",
              ),
              const Spacer(),
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  "assets/images/Circle.png",
                ),
              ),
            ],
          ),
          Text(
            text,
            style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.grey),
          ),
        ],
      ),
    );
  }
}