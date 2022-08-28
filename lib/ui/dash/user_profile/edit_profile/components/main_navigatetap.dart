import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class MainNavigateTap extends StatelessWidget {
  const MainNavigateTap({
    required this.title,
    required this.desc,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final String title;
  final String desc;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: (){
            onTap();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25,),
              Row(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ColorPlate.primaryLightBG),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * .8,
                child: Text(
                  desc,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: ColorPlate.secondaryLightBG),
                ),
              ),
              const SizedBox(height: 20,),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        const Divider(
          height: 1,
          thickness: 1,
          color: ColorPlate.neutral90,
        ),
        const SizedBox(height: 25,),

      ],
    );
  }
}
