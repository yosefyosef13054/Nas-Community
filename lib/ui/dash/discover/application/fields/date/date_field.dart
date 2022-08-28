import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';



class DateApplicationField extends StatelessWidget {
  const DateApplicationField({Key? key, required this.config}) : super(key: key);
  final ApplicationConfig config;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(config.inputSectionKey.name),
    );
  }
}
