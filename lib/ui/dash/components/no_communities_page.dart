import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';


class NoCommunitiesPAge extends StatelessWidget {
  const NoCommunitiesPAge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 60,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black,),
          onPressed: (){
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
              children: const [
                Text("You have no communities", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 40, color: ColorPlate.tertiaryLightBG),),
                SizedBox(height: 15,),
                Text("Join communities ...", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: ColorPlate.tertiaryLightBG),)
              ],
            ),
            const Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.search, size: 100, color: ColorPlate.yellow90,)),
          ],
        ),
      ),
    );
  }
}
