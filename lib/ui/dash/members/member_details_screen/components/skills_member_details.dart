import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nas_academy/core/services/navigator.dart';
import 'package:nas_academy/core/utils/assets.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/ui/dash/user_profile/edit_profile/edit_skills_and_interests/edit_skills_and_interests.dart';


class SkillsMemberDetails extends StatefulWidget {
  const SkillsMemberDetails({Key? key, required this.list, required this.title, this.bottomDivider, required this.userProfile, required this.topDivider}) : super(key: key);
  final List<String> list;
  final String title;
  final bool? bottomDivider;
  final bool? topDivider;
  final bool userProfile;

  @override
  State<SkillsMemberDetails> createState() => _SkillsMemberDetailsState();
}

class _SkillsMemberDetailsState extends State<SkillsMemberDetails> {
  bool _expanded = false;
  int numberToShow = 4;
  @override
  Widget build(BuildContext context) {
    if(widget.list.isNotEmpty){
     return Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       mainAxisSize: MainAxisSize.min,
       children: [
         Visibility(
           visible:widget.topDivider == true,
           child: const SizedBox(height: 30,),
         ),
         Visibility(
           visible:widget.topDivider == true,
           child: const Divider(
             color:  ColorPlate.neutral80,
           ),
         ),
         const SizedBox(
           height: 10,
         ),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Text(
               widget.title,
               style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
             ),
             Visibility(
               visible: widget.userProfile,
               child: IconButton(
                 icon: SvgPicture.asset(Assets.edit, height: 24, width: 24,),
                 onPressed: (){
                   Navigate.push(context, const EditSkillsAndInterests());
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
           child: Wrap(
             alignment: WrapAlignment.start,
             spacing: 8,
             runSpacing: 12,
             children: widget.list.take(numberToShow).map((item) => Container(
               decoration: BoxDecoration(
                   color:  ColorPlate.yellow90,
                   borderRadius: BorderRadius.circular(8)
               ),
               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
               child: Text(item, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),),
             )
             ).toList(),
           ),
         ),
         Visibility(
           visible: widget.list.length > 4,
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
                       if(_expanded){
                         numberToShow = widget.list.length;
                       }else {
                         numberToShow = 4;
                       }
                     });
                   },
                 ),
               ),
             ),
           ),
         ),
         const SizedBox(
           height: 10,
         ),
         Visibility(
           visible:widget.bottomDivider == true,
           child: const Divider(
             height: 50,
             color:  ColorPlate.neutral80,
           ),
         ),
         Visibility(
           visible:widget.bottomDivider == true,
           child: const SizedBox(height: 30,),
         ),
       ],
     );
    }else {
      return const SizedBox(height: 0, width: 0,);
    }
  }
}
