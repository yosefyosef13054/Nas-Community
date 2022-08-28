import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:google_fonts/google_fonts.dart';

class IconContainer extends StatelessWidget {
  const IconContainer({
    Key? key,
    required this.onTap,
    required this.image,
    required this.text,
    this.theme = Brightness.dark,
    this.imageColor,
  }) : super(key: key);

  final Function onTap;
  final String image;
  final String text;
  final Brightness theme;
  final Color? imageColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(48))),
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          elevation: MaterialStateProperty.all(0)),
      onPressed: () async => onTap(),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(48),
          border: Border.all(
              color: theme == Brightness.dark ? Colors.white : Colors.black,
              width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 22,
              color: imageColor,
            ),
            const SizedBox(
              width: 0,
            ),
            Center(
              child: Text(
                text,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: theme == Brightness.dark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(
              width: 0,
            ),
            const SizedBox(
              width: 0,
            ),
          ],
        ),
      ),
    );
  }
}
