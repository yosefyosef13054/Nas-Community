import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nas_academy/core/services/launcher.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({Key? key}) : super(key: key);

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
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        physics: const BouncingScrollPhysics(),
        children: [
          const Text(
            'Help desk',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 28,
              color: ColorPlate.primaryLightBG,
            ),
          ),
          const SizedBox(
            height: 46,
          ),
          ListTile(
            minLeadingWidth: 20,
            contentPadding: const EdgeInsets.all(0),
            title: const Text(
              'Report an incident or a member',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
                color: ColorPlate.primaryLightBG,
              ),
            ),
            subtitle: const Text(
              'Please complete this form and share full details of the accident',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: ColorPlate.neutral50,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 14,
            ),
            selected: true,
            onTap: () {
               Launcher.launchEmail("hello@nas.io");
            },
          ),
          const Divider(
            height: 30,
            thickness: 1,
            endIndent: 0,
            color: ColorPlate.neutral90,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Reach out to us',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: ColorPlate.primaryLightBG,
                ),
              ),
              InkWell(
                onTap: () {
                  Launcher.launchEmail("hello@nas.io");
                },
                child: Container(
                  height: 32,
                  width: 83,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(48),
                      border: Border.all(width: 1)),
                  child: const Center(
                    child: Text(
                      'Email Us',
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
          const Divider(
            height: 30,
            thickness: 1,
            endIndent: 0,
            color: ColorPlate.neutral90,
          ),
        ],
      ),
    );
  }
}
