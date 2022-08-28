import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/services/permission_handler.dart';
import 'package:nas_academy/core/utils/color_plate.dart';


class PendingApplication extends StatefulWidget {
  const PendingApplication({Key? key, required this.community}) : super(key: key);
  final Item community;
  @override
  State<PendingApplication> createState() => _PendingApplicationState();
}

class _PendingApplicationState extends State<PendingApplication> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            systemOverlayStyle: SystemUiOverlayStyle.light,
            toolbarHeight: 180,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(widget.community.fields?.bannerSection?.fullScreenBannerImgData?.mobileImgProps.src ?? "", fit: BoxFit.cover,),
            ),
            bottom: PreferredSize(
              preferredSize: Size(MediaQuery.of(context).size.width, 40),
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                  color: ColorPlate.neutral90
                ),
                child: const Center(
                  child: Text("Pending approval", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: ColorPlate.secondaryLightBG),),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            fillOverscroll: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Your application for ${(widget.community.fields?.bannerSection?.communityTitle ?? "community").toString()} has been received successfully.", style:const  TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  const SizedBox(height: 12,),
                  const Text("You will hear from us within a day", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16, color: ColorPlate.secondaryLightBG),),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 25),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<bool>(
              initialData: true,
              future: PermissionHandlerService().notificationEnabled(),
              builder: (context, snapshot) {
                return Visibility(
                  visible: !snapshot.data!,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: SizedBox(
                        height: 45,
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton.icon(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                            foregroundColor: MaterialStateProperty.all(ColorPlate.primaryLightBG)),
                          label: const Text("Notify me when approved"),
                          icon: const Icon(Icons.notifications_active_outlined),
                          onPressed: ()async{
                            await PermissionHandlerService().notificationsRequest(context);
                            setState((){});
                          },
                        ),
                      ),
                    ));
              }
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                style: ButtonStyle(
                    elevation: MaterialStateProperty.all(0),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)))
                ),
                child: const Text("Continue", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                onPressed: (){
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
