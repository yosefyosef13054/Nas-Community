import 'package:flutter/material.dart';



class NewBadge extends StatelessWidget {
  const NewBadge({Key? key, required this.show}) : super(key: key);
  final bool show;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color(0xFFD4EBFC)
        ),
        child: const Text("New", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 10, color: Color(0xFF005BA1)),),
      ),
    );
  }
}
