import 'package:any_link_preview/any_link_preview.dart';
import "package:flutter/material.dart";
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/members/member_details_screen/components/spotlight.dart';
import 'package:provider/provider.dart';


class NewSpotlightPreview extends StatelessWidget {
  const NewSpotlightPreview({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    if(profile.validLink()){
      return FutureBuilder<Metadata?>(
        future: getLinkMetaData(profile.spotlightLink), 
        builder: (context, snapshot) {
          if(snapshot.hasData && snapshot.data != null){
            final Metadata data = snapshot.data!;
            return Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ColorPlate.neutral97,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(data.image ?? "", height: 64, width: 64, fit: BoxFit.cover,),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.title ?? "Title", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14,),),
                        const SizedBox(height: 5,),
                        Text(Uri.parse(profile.spotlightLink).host, style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 12, color: ColorPlate.secondaryLightBG),),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }else {
            return const Loading(color: Colors.transparent,);
          }
        }
      );
    }else {
      return const SizedBox(height: 0, width: 0,);
    }

  }
}
