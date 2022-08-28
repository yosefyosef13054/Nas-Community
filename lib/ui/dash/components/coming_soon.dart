import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key? key, required this.title, this.discover})
      : super(key: key);
  final String title;
  final bool? discover;
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        leading: discover == true
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 18,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  dash.drawerController.toggle!();
                },
              ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 28),
                ),
                const SizedBox(
                  height: 35,
                ),
                const Text(
                  "Coming soon",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 40,
                      color: ColorPlate.tertiaryLightBG),
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Building in progress...",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: ColorPlate.tertiaryLightBG),
                )
              ],
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: Image.asset(
                  "assets/images/coming_soon.png",
                  height: 160,
                  width: 160,
                )),
          ],
        ),
      ),
    );
  }
}
