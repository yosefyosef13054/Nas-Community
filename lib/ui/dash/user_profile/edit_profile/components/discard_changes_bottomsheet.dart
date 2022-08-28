import 'package:flutter/material.dart';
import 'package:nas_academy/core/utils/color_plate.dart';

class DiscardChangesDropDown extends StatelessWidget {
  const DiscardChangesDropDown({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        child: Material(
          color: ColorPlate.neutral100,
          child: SafeArea(
            top: false,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 16),
                  child: Row(
                    children: [
                      const Text(
                        'Discard changes?',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: ColorPlate.primaryLightBG),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.close,
                            color: ColorPlate.neutral70,
                          ))
                    ],
                  ),
                ),
                const Divider(
                  height: 50,
                  thickness: 1,
                  color: ColorPlate.neutral90,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: OutlinedButton(
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(const BorderSide(
                              width: 1.0, color: ColorPlate.secondaryLightBG)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(48)))),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Discard',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.red),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Center(
                    child: Text(
                      'Continue editing',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ColorPlate.primaryLightBG),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 55,
                ),
              ],
            ),
          ),
        ));
  }
}
