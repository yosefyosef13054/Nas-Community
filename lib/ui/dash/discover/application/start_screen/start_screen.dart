import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key, required this.community}) : super(key: key);
  final Item community;
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        primary: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          // borderRadius: BorderRadius.circular(180),
          icon: Container(
            height: 32,
            width: 32,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: Colors.white),
            child: const Center(
                child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 14,
              color: Colors.black,
            )),
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Hero(
            tag:"${community.fields?.bannerSection?.fullScreenBannerImgData?.mobileImgProps.src}",
            child: Image.network(
              community.fields!.bannerSection!.fullScreenBannerImgData!.mobileImgProps.src!,
              width: MediaQuery.of(context).size.width,
              loadingBuilder: (context, child, progress){
                if(progress != null && progress.cumulativeBytesLoaded < progress.expectedTotalBytes!){
                  return Shimmer.fromColors(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      color: Colors.grey[500]!,),
                    highlightColor: Colors.white,
                    baseColor: Colors.grey[300]!,
                  );
                }else {
                  return child;
                }
              },
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              community.fields!.bannerSection!.communityTitle!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: ColorPlate.blurple60),
            ),
          )),
          const SizedBox(
            height: 8,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                community.fields!.bannerSection!.communitySubtitle!,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: SizedBox(
            height: 55,
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)))),
              child: const Text("Apply to join", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
              onPressed: () {
                application.mainController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut);

              },
            ),
          )
          ),
        ],
      ),
    );
  }
}
