import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/static_lists.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/country_pick.dart';
import 'package:provider/provider.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);
  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    final profile = Provider.of<ProfileProvider>(context, listen: false);
    final user = Provider.of<User?>(context, listen: false);
    List<Country> country = StaticList.countries.where((element) => (user?.learner.phoneNumber ?? "").contains(element.dialCode)).toList();
    _controller = TextEditingController(text: profile.country ?? user?.learner.country ?? user?.country ?? (country.isNotEmpty? country.first.name : null));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    return InkWell(
      onTap: () {
        showBarModalBottomSheet(
            context: context,
            builder: (context) {
              return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: CountryPickerBottomSheet(onSelected: (Country country)async{
                    profile.setCountry = country.name;
                    _controller.text = country.name;
                    Navigator.pop(context);
                  },));
            });
      },
      child: IgnorePointer(
        ignoring: true,
        child: TextFormField(
          controller: _controller,
          decoration: const InputDecoration(
            suffixIcon: Icon(Icons.keyboard_arrow_down_outlined),
            label: Text(
              "Country",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: ColorPlate.primaryLightBG),
            ),
          ),
          onChanged: (val) {
            profile.setCountry = val;
          },
        ),
      ),
    );
  }
}
