import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/modules/member/member.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_type.dart';
import 'package:nas_academy/ui/common/my_icons.dart';
import 'package:nas_academy/ui/dash/meet_an_expert/calendly_view/calendly_view.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MemberDetailsFab extends StatefulWidget {
  const MemberDetailsFab({Key? key, required this.member, this.booked})
      : super(key: key);
  final Member member;
  final bool? booked;

  @override
  State<MemberDetailsFab> createState() => _MemberDetailsFabState();
}

class _MemberDetailsFabState extends State<MemberDetailsFab> {
  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    if (widget.member.role == MemberRole.trainer) {
      if (widget.booked == true) {
        return ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(5),
              foregroundColor: MaterialStateProperty.all(ColorPlate.blurple60),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15))),
          onPressed: () async {
            final String? _telegram = widget.member.telegramUsername;
            if (_telegram != null) {
              await launchUrl(Uri.parse("https://telegram.me/$_telegram"));
            } else {
              final String _email = "mailto:${widget.member.email}?";
              await launchUrl(Uri.parse(_email));
            }
          },
          icon: SvgPicture.asset(
            "assets/svg/trainer_stroke.svg",
            color: ColorPlate.blurple60,
          ),
          label: const Text(
            "1 upcoming meeting",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      } else {
        return ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(5),
              foregroundColor: MaterialStateProperty.all(ColorPlate.blurple60),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15))),
          onPressed: () {
            if (dash.activeCommunity != null && dash.communities.elementAt(dash.communitiesIndex).id == dash.activeCommunity!.id!) {
              Navigate.push(
                  context,
                  CalendlyView(
                      trainer: widget.member,
                      back: true,
                      communityId: dash.activeCommunity!.id!,
                      refresh: () {
                        setState(() {});
                        dash.notify();
                      }));
            }
          },
          icon: SvgPicture.asset(
            "assets/svg/trainer_stroke.svg",
            color: ColorPlate.blurple60,
          ),
          label: const Text(
            "Book a time with me",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      }
    } else {
      if (widget.member.telegramUsername != null &&
          widget.member.telegramUsername!.isNotEmpty) {
        return ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(5),
              foregroundColor: MaterialStateProperty.all(ColorPlate.blurple60),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15))),
          onPressed: () async {
            final String? _telegram = widget.member.telegramUsername;
            await launchUrl(Uri.parse("https://telegram.me/$_telegram"));
          },
          icon: const Icon(MyIcons.telegram),
          label: const Text(
            "Reach out to me",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      } else if (widget.member.email != null &&
          widget.member.email!.isNotEmpty) {
        return ElevatedButton.icon(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.white),
              elevation: MaterialStateProperty.all(5),
              foregroundColor: MaterialStateProperty.all(ColorPlate.blurple60),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16))),
              padding: MaterialStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15))),
          onPressed: () async {
            final String _email = "mailto:${widget.member.email}?";
            await launchUrl(Uri.parse(_email));
          },
          icon: const Icon(Icons.email),
          label: const Text(
            "Reach out to me",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        );
      } else {
        return const SizedBox(
          height: 0,
          width: 0,
        );
      }
    }
  }
}
