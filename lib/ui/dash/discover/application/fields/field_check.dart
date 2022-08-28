import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/utils/color_plate.dart';
import 'package:nas_academy/core/utils/data_types.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/check_box/check_box.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/date/date_field.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/multi_select/multi_select.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/number/number.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/radio/radio.dart';
import 'package:nas_academy/ui/dash/discover/application/fields/string/string.dart';

import 'package:provider/provider.dart';


class FieldsCheck extends StatelessWidget {
  const FieldsCheck({Key? key, required this.config, required this.allConfigs, required this.comCode}) : super(key: key);
  final ApplicationConfig config;
  final List<ApplicationConfig> allConfigs;
  final String comCode;
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    return  Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: application.nextEnabled(config)? ColorPlate.yellow70 : ColorPlate.neutral95,
        onPressed: application.nextEnabled(config)?()async{
           await application.next(allConfigs, context, comCode);
        } : null,
        elevation: 0,
        child: Icon(Icons.arrow_forward, size : 23,color: application.nextEnabled(config)?Colors.black : ColorPlate.tertiaryLightBG,),
      ),
      body: Builder(
        builder: (context){
          switch (config.inputSectionKey) {
            case InputType.text : return StringApplicationField(config: config);
            case InputType.number : return NumberApplicationField(config: config);
            case InputType.checkbox : return CheckboxApplicationField(config: config);
            case InputType.date : return DateApplicationField(config: config);
            case InputType.radio : return RadioApplicationField(config: config);
            case InputType.multiSelectModal : return MultiSelectApplicationField(config: config);
            default : return StringApplicationField(config: config);
          }
        },
      ),
    );

  }
}
