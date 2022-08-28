import 'package:flutter/material.dart';

import '../../../../../core/modules/contentfull/contentfull_model.dart';
import '../../../../../core/utils/color_plate.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.text,
    this.fontsize,
    this.fontWeight,
    this.textcolor,
    this.nomaxLines,
    Key? key,
  }) : super(key: key);
  final dynamic text;
  final double? fontsize;
  final bool? nomaxLines;
  final FontWeight? fontWeight;
  final Color? textcolor;
  @override
  Widget build(BuildContext context) {
    return text is String
        ? Text(
            text.toString(),
            maxLines: nomaxLines == true ? null : 4,
            style: TextStyle(
              fontWeight: fontWeight,
              fontSize: fontsize,
              color: textcolor,
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...text.map(
                (List<DescriptionItem> e) => Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    e.first.text.toString(),
                    maxLines: nomaxLines == true ? null : 4,
                    style: TextStyle(
                      decoration: e.first.isUnderlined == true
                          ? TextDecoration.underline
                          : null,
                      fontWeight: e.first.isBolder == true
                          ? FontWeight.w600
                          : FontWeight.w500,
                      fontSize: 16,
                      color: e.first.isHighlighted == true
                          ? ColorPlate.yellow70
                          : ColorPlate.primaryLightBG,
                    ),
                  ),
                ),
              ),
            ],
          );
  }
}
