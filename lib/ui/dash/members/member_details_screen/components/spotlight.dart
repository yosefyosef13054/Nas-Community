import 'package:any_link_preview/any_link_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:line_icons/line_icons.dart';
import 'package:nas_academy/core/modules/exceptions/server_error.dart';
import 'package:nas_academy/core/modules/user/sub/soptlight.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_spotlight/edit_spotlight.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';



class Spotlight extends StatelessWidget {
  const Spotlight({Key? key, required this.userProfile,required this.spotlight, required this.visible}) : super(key: key);
  final SpotLight? spotlight;
  final bool visible;
  final bool userProfile;
  @override
  Widget build(BuildContext context) {
    final profile = userProfile? Provider.of<ProfileProvider>(context) : null;
    if(spotlight != null && spotlight!.link != null && spotlight!.link!.isNotEmpty && visible && AnyLinkPreview.isValidLink(spotlight!.link!)){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisSize: MainAxisSize.min,
       children: [
         const Divider(
             color: ColorPlate.neutral80
         ),
         const SizedBox(
           height: 10,
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             const Text(
               "Spotlight",
               style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
             ),
             Visibility(
               visible: userProfile,
               child: IconButton(
                 icon: SvgPicture.asset(Assets.edit, height: 24, width: 24,),
                 onPressed: (){
                   Navigate.push(context, ChangeNotifierProvider<ProfileProvider>.value(
                       value: profile!,
                       child: const EditSpotlight()));
                 },
               ),
             ),
           ],
         ),
         const SizedBox(
           height: 20,
         ),
         spotlight!.link != null && spotlight!.link!.isNotEmpty ? FutureBuilder<Metadata?>(
           future: getLinkMetaData(spotlight!.link!),
           builder: (context, snapshot){
             if(snapshot.hasData && snapshot.data != null){
               Metadata meta = snapshot.data!;
               String host = Uri.parse(meta.url?? "").host;
               return  Column(
                 children: [
                   Container(
                     height : 200,
                     width : MediaQuery.of(context).size.width,
                     decoration: const BoxDecoration(
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)) ,
                     ),
                     child: ClipRRect(
                       borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)) ,
                       child: Image.network(
                         spotlight!.thumbnail ?? meta.image ?? "",
                         fit: BoxFit.cover,
                         errorBuilder: (context, child, error){
                           return Container(
                             decoration: const BoxDecoration(
                                 borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25)) ,
                                 color: ColorPlate.neutral80
                             ),
                             child: const Center(
                               child: Icon(LineIcons.image, size: 80,),
                             ),
                           );
                         },
                       ),
                     ),
                   ),
                   Container(
                     padding : const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                     width : MediaQuery.of(context).size.width,
                     decoration: const BoxDecoration(
                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
                         color: ColorPlate.neutral95
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       mainAxisSize : MainAxisSize.min,
                       children: [
                         Text("${spotlight!.title ?? meta.title}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                         const SizedBox(height: 5,),
                         Text(
                           host.replaceAll("www", ""),
                           style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: ColorPlate.secondaryLightBG),
                         ),
                         const SizedBox(height: 5,),
                         Text(
                           "${spotlight!.description ?? meta.desc}",
                           style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
                         ),
                       ],
                     ),
                   ),
                 ],
               );
             }else if (snapshot.hasError){
               return Center(
                 child: Column(
                   mainAxisSize: MainAxisSize.min,
                   children: const [
                     Icon(LineIcons.exclamationCircle, size: 40, color: ColorPlate.secondaryLightBG,),
                     SizedBox(height: 20,),
                     Text("Unable to view link meta data", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: ColorPlate.secondaryLightBG),),
                   ],
                 ),
               );
             }else {
               return Shimmer.fromColors(
                 baseColor: Colors.grey[300]!,
                 highlightColor: Colors.white,
                 child: Container(
                   height: 300,
                   decoration: BoxDecoration(
                     color: Colors.grey,
                     borderRadius: BorderRadius.circular(30),
                   ),
                   width: MediaQuery.of(context).size.width,
                 ),
               );
             }
           },
         ) : const SizedBox(height: 0, width: 0,),
       ],
     );
    }else {
      return const SizedBox(height: 0, width: 0,);
    }
  }
}


Future<Metadata?> getLinkMetaData (String link)async{
  if(AnyLinkPreview.isValidLink(link)){
    Metadata? _metadata = await AnyLinkPreview.getMetadata(
      link: Uri.parse(link).toString(),
      cache: const Duration(days: 70), // Need for web
    );
    return _metadata;
  }else {
    throw ServerError(
      title: "Failed to get spotlight data",
      body: "link is corrupted",
    );
  }
}
