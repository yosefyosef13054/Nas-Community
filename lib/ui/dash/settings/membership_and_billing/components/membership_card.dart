import 'package:flutter/material.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/settings/membership_and_billing/billing_history_screen.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: ColorPlate.neutral200,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                CircleAvatar(
                  radius: 28.0,
                  backgroundImage:
                      NetworkImage('https://via.placeholder.com/150'),
                  backgroundColor: Colors.transparent,
                ),
                SizedBox(
                  width: 16,
                ),
                Flexible(
                  child: Text(
                    'Community Name',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPlate.primaryLightBG,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'USD 29/mo',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              'Next billing date: dd/mm/yyyy',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorPlate.neutral50,
              ),
            ),
            const Divider(
              height: 30,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: ColorPlate.neutral90,
            ),
            Row(
              children: [
                const Spacer(),
                InkWell(
                  onTap: () {
                    Navigate.push(context, const BillingHistoryScreen());
                  },
                  child: Container(
                    height: 32,
                    width: 83,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(48),
                        border: Border.all(width: 1)),
                    child: const Center(
                      child: Text(
                        'Manage',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ColorPlate.primaryLightBG,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
