import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/settings/membership_and_billing/components/membership_card.dart';

class MembershipBillingScreen extends StatefulWidget {
  const MembershipBillingScreen({Key? key}) : super(key: key);

  @override
  State<MembershipBillingScreen> createState() =>
      _MembershipBillingScreenState();
}

class _MembershipBillingScreenState extends State<MembershipBillingScreen> {
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
          children: const [
            Text(
              'Membership & Billing',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 28,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            SizedBox(
              height: 36,
            ),
            MembershipCard(),
          ],
        ),
      ),
    );
  }
}
