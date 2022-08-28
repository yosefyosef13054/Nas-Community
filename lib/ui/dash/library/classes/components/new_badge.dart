import 'package:flutter/material.dart';


class LibraryNewBadge extends StatelessWidget {
  const LibraryNewBadge({Key? key, required this.visible}) : super(key: key);
  final bool visible;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(
            colors: [Color(0xFFFBC91B), Color(0xFFFF834E)]
          )
        ),
        child: const Text("NEW", style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.white),),
      ),
    );
  }
}
