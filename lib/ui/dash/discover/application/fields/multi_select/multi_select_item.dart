import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:provider/provider.dart';



class MultiSelectItem extends StatelessWidget {
  const MultiSelectItem({Key? key, required this.config, required this.option}) : super(key: key);
  final ApplicationConfig config;
  final MultiSelectOption option;
  @override
  Widget build(BuildContext context) {
      final bool selected = config.value.any((element) => element.value == option.value);
      final application = Provider.of<ApplicationProvider>(context);
    return  ListTile(
      contentPadding: EdgeInsets.zero,
      onTap: (){
        if(selected){
          config.value.removeWhere((element) => element.value == option.value);
        }else {
          config.value.add(option);
        }
        application.notify();
      },
      title: Text(
      option.label
      , style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
      leading: SizedBox(
        height: 24,
        width: 24,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              border: Border.all(color: selected?  Colors.black :ColorPlate.neutral80),
              color: selected?  Colors.black : Colors.transparent
          ),
          child: selected? const Center(child: Icon(Icons.check, color: Colors.white, size: 18,)) : null,
        ),
      ),
    );
  }
}
