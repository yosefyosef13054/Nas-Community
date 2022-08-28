import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';



class RadioSelectionItem extends StatelessWidget {
  const RadioSelectionItem({Key? key, required this.config, required this.option}) : super(key: key);
  final ApplicationConfig config;
  final MultiSelectOption option;
  @override
  Widget build(BuildContext context) {
    final bool selected = config.value == option.value;
    final application = Provider.of<ApplicationProvider>(context);
    return  ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      onTap: (){
        if(selected){
          config.value = null;
        }else {
          config.value = option.value;
        }
        application.notify();
      },
      title: Text(
        option.label
        , style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
      leading: SizedBox(
        child: AnimatedContainer(
          height: 24,
          width: 24,
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: selected?  Colors.black :ColorPlate.neutral80),
              // color: selected?  Colors.black : Colors.transparent
          ),
          child: selected? Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: selected?  Colors.black :ColorPlate.neutral80),
                color: selected?  Colors.black : Colors.transparent
            ),
          ) : null,
        ),
      ),
    );
  }
}
