import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';



class NasTeamBadge extends StatelessWidget {
  const NasTeamBadge({Key? key, required this.show}) : super(key: key);
  final bool show;
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
        height: 16,
        width: 16,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: const Color(0xFF3549E6)
        ),
        child: Center(child: SvgPicture.asset("assets/svg/nas_badge.svg", color: Colors.white, height: 11, width: 11,)),
      ),
    );
  }
}
