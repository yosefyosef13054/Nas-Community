import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_bio/edit_bio.dart';
import 'package:provider/provider.dart';

class AboutMemberDetails extends StatefulWidget {
  const AboutMemberDetails({Key? key, required this.sub, required this.userProfile}) : super(key: key);
  final String sub;
  final bool userProfile;

  @override
  State<AboutMemberDetails> createState() => _AboutMemberDetailsState();
}

class _AboutMemberDetailsState extends State<AboutMemberDetails> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final bool showButton = hasTextOverflow(widget.sub, const TextStyle(fontSize: 16, fontWeight: FontWeight.w400), maxLines: 3, minWidth: 20, maxWidth: MediaQuery.of(context).size.width - 48);
    final profile = widget.userProfile? Provider.of<ProfileProvider>(context) : null;
    return Visibility(
      visible: widget.sub.isNotEmpty,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(
            color: ColorPlate.neutral80,
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "About",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
              ),
              Visibility(
                visible: widget.userProfile,
                child: IconButton(
                  icon: SvgPicture.asset(Assets.edit, height: 24, width: 24, color: Colors.black,),
                  onPressed: (){
                    Navigate.push(context, ChangeNotifierProvider<ProfileProvider>.value(
                        value: profile!,
                        child: const EditBio()));
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 250),
            alignment: Alignment.topCenter,
            curve: Curves.fastOutSlowIn,
            child: Text(
              widget.sub,
              overflow: TextOverflow.ellipsis,
              maxLines: _expanded ? 20 : 3,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
          ),
          Visibility(
            visible: showButton,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all(ColorPlate.secondaryLightBG),
                    ),
                    icon: Icon(
                      _expanded
                          ? Icons.keyboard_arrow_up_sharp
                          : Icons.keyboard_arrow_down_sharp,
                      size: 18,
                    ),
                    label: Text(_expanded ? "show less" : "show more"),
                    onPressed: () {
                      setState(() {
                        _expanded = !_expanded;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: !showButton,
            child: const SizedBox(height: 20,),
          ),
        ],
      ),
    );
  }
}


bool hasTextOverflow(
    String text,
    TextStyle style,
    {double minWidth = 0,
      double maxWidth = double.infinity,
      int maxLines = 2
    }) {
  final TextPainter textPainter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  )..layout(minWidth: minWidth, maxWidth: maxWidth);
  return textPainter.didExceedMaxLines;
}