import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/multi_select/multi_select_item.dart';



class MultiSelectApplicationField extends StatelessWidget {
  const MultiSelectApplicationField({Key? key, required this.config}) : super(key: key);
  final ApplicationConfig config;
  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).unfocus();
    if(config.value is! List<MultiSelectOption> ){
      config.value = <MultiSelectOption>[];
    }
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      children: [
       Text(config.label?? "", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
        const SizedBox(height: 25,),
        Column(
          children: config.options.map((e) => MultiSelectItem(config: config, option: e,)).toList(),
        )
      ],
    );
  }
}
