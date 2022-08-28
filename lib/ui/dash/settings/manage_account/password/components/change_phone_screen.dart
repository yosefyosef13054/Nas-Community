import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nas_academy/core/api/edit_profile/edit_profile.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/messenger.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/static_lists.dart';
import 'package:nas_academy/ui/common/loading.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/components/country_pick.dart';
import 'package:provider/provider.dart';

class ChangePhoneNumberScreen extends StatefulWidget {
  const ChangePhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumberScreen> createState() =>
      _ChangePhoneNumberScreenState();
}

class _ChangePhoneNumberScreenState extends State<ChangePhoneNumberScreen> {
  String _newPhoneNumber = "";
  String _countryCode = "";
  late TextEditingController _controller;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    final user = Provider.of<User?>(context, listen: false);
    final List<Country> init = StaticList.countries
        .where((element) =>
            ((user?.learner.country ?? user?.country)
                    .toString()
                    .toLowerCase() ==
                element.name.toLowerCase()) ||
            (user?.learner.phoneNumber ?? "").contains(element.dialCode))
        .toList();
    _controller = TextEditingController(
        text: init.isNotEmpty
            ? "${init.first.name} (${init.first.dialCode})"
            : null);
    if(init.isNotEmpty){
      _countryCode = init.first.dialCode;
      _newPhoneNumber = (user?.learner.phoneNumber??"").replaceAll(_countryCode, "");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileProvider>(context);
    final user = Provider.of<User?>(context);
    final bool valid = _newPhoneNumber.isNotEmpty &&
        _countryCode.isNotEmpty &&
        "$_countryCode $_newPhoneNumber".replaceAll(" ", "") !=
            (user?.learner.phoneNumber ?? "").replaceAll(" ", "");
    return Scaffold(
      backgroundColor: ColorPlate.neutral100,
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: 64,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Change password',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorPlate.primaryLightBG),
        ),
        shadowColor: ColorPlate.neutral90,
        backgroundColor: ColorPlate.neutral100,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(left: 20),
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: ColorPlate.primaryLightBG),
              ),
            ),
          ),
        ),
        actions: [
          Center(
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      valid ? ColorPlate.yellow70 : ColorPlate.neutral90),
                  foregroundColor: MaterialStateProperty.all(
                      valid ? Colors.black : ColorPlate.tertiaryLightBG),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100))),
                  elevation: MaterialStateProperty.all(0)),
              onPressed: valid
                  ? () async {
                      try {
                        setState(() => _loading = true);
                        await const EditProfile().updatePhoneNumber("$_countryCode$_newPhoneNumber");
                        user!.learner.phoneNumber = "$_countryCode$_newPhoneNumber";
                        await UserLocalDB.saveUser(user);
                        profile.notify();
                        setState(() => _loading = false);
                        Messenger.showSuccessSnackBar(context);
                        Navigator.pop(context);
                      } catch (e) {
                        setState(() => _loading = false);
                      }
                    }
                  : null,
              child: const Text("Save"),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(25),
            shrinkWrap: true,
            children: [
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showBarModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: CountryPickerBottomSheet(
                              onSelected: (Country country) {
                                setState(() {
                                  _countryCode = country.dialCode;
                                });
                                _controller.text =
                                    "${country.name} (${country.dialCode})";
                                Navigator.pop(context);
                              },
                            ));
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
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                onChanged: (val) => setState(() => _newPhoneNumber = val),
                initialValue: _newPhoneNumber,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: const InputDecoration(
                    labelText: "Phone number",
                    labelStyle: TextStyle(color: ColorPlate.primaryLightBG)),
              ),
            ],
          ),
          _loading ? const Loading() : const SizedBox(),
        ],
      ),
    );
  }
}
