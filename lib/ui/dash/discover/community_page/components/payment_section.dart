import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/contentfull/contentfull_model.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/core/utils/extensions.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/apply_button.dart';
import 'package:nas_academy/ui/dash/discover/community_page/components/shared_widgets/bullet_text.dart';
import 'package:provider/provider.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection(
      {Key? key, required this.community, required this.status})
      : super(key: key);
  final Item community;
  final ApplicationStatusType? status;

  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pay little. Get a lot.',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24,
            color: ColorPlate.primaryLightBG,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorPlate.neutral97,
          ),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24,
            ),
            child: Column(
              children: [
                Text(
                  application.products.where((element) => element.id == community.fields?.appSubscriptionProductId).isNotEmpty? "${ application.products.where((element) => element.id == community.fields?.appSubscriptionProductId).first.currencySymbol} ${ application.products.where((element) => element.id == community.fields?.appSubscriptionProductId).first.rawPrice.thousandFormat}"  : '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ApplyButton(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    status: status,
                    community: community,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Applications will be subjected to approval',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: ColorPlate.neutral50,
                  ),
                ),
                const Divider(
                  height: 30,
                  thickness: 1,
                  endIndent: 0,
                  color: ColorPlate.neutral90,
                ),
                Column(
                  children: community.fields!.pricingSection!.ctaItems
                      .map((e) => BulletText(
                            bulletColor: ColorPlate.yellow70,
                            text: e,
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
