import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart'
    as model;
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/custom_textfield.dart';

class WhatsInsideSection extends StatelessWidget {
  const WhatsInsideSection({
    required this.items,
    Key? key,
  }) : super(key: key);
  final List<model.Item> items;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomTextField(
          text: items[0].fields!.whyJoinSection!.title,
          fontsize: 24,
          fontWeight: FontWeight.w600,
          textcolor: ColorPlate.primaryLightBG,
        ),
        const SizedBox(
          height: 24,
        ),
        SizedBox(
          height: 480.0,
          child: Swiper(
            viewportFraction: 0.9,
            loop: false,
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(), // this for snapping
            itemCount: items[0].fields!.whyJoinSection!.cards.length,
            itemBuilder: (_, index) => _buildCarouselItem(
                items[0].fields!.whyJoinSection!.cards[index]),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(model.Card card) {
    return Padding(
      padding: const EdgeInsets.only(right: 24.0),
      child: Container(
        width: 301,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.network(
                    "https://d2oi1rqwb0pj00.cloudfront.net/nasIO/nas-product-language/svg/${card.icon.toString()}.svg",
                    height: 28,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextField(
                      text: card.title,
                      fontsize: 20,
                      fontWeight: FontWeight.w600,
                      textcolor: ColorPlate.primaryLightBG),
                  const SizedBox(
                    height: 12,
                  ),
                  CustomTextField(
                      text: card.description,
                      fontsize: 14,
                      fontWeight: FontWeight.w400,
                      textcolor: ColorPlate.neutral50),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12.0),
                  bottomRight: Radius.circular(12.0),
                ),
                image: DecorationImage(
                  // fit: BoxFit.cover,
                  image: NetworkImage(card.image.mobileImgProps.src.toString()),
                ),
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ColorPlate.neutral97,
        ),
      ),
    );
  }
}
