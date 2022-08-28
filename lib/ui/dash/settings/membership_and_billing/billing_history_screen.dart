import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/settings/membership_and_billing/components/billing_card.dart';

class BillingHistoryScreen extends StatefulWidget {
  const BillingHistoryScreen({Key? key}) : super(key: key);

  @override
  State<BillingHistoryScreen> createState() => _BillingHistoryScreenState();
}

class _BillingHistoryScreenState extends State<BillingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
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
            ListTile(
              minLeadingWidth: 20,
              contentPadding: const EdgeInsets.all(0),
              title: const Text(
                'Manage your subscription preferences by going to your iTune account ',
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  color: ColorPlate.neutral50,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
                size: 14,
              ),
              onTap: () {},
            ),
            const Divider(
              height: 30,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: ColorPlate.neutral90,
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Billing History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Details',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
                Text(
                  'Price',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: ColorPlate.primaryLightBG,
                  ),
                ),
              ],
            ),
            const Divider(
              height: 30,
              thickness: 1,
              indent: 0,
              endIndent: 0,
              color: ColorPlate.neutral90,
            ),
            const BillingCard()
          ],
        ),
      ),
    );
  }
}
