import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/radio/radio_selection_item.dart';



class RadioApplicationField extends StatelessWidget {
  const RadioApplicationField({Key? key, required this.config}) : super(key: key);
  final ApplicationConfig config;
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(config.label?? "", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
        ),
        const SizedBox(height: 25,),
        Column(
          children: config.options.map((e) => RadioSelectionItem(config: config, option: e,)).toList(),
        )
      ],
    );
  }
}
