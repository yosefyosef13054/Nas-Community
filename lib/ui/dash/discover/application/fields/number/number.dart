import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:provider/provider.dart';



class NumberApplicationField extends StatefulWidget {
  const NumberApplicationField({Key? key, required this.config}) : super(key: key);
  final ApplicationConfig config;

  @override
  State<NumberApplicationField> createState() => _NumberApplicationFieldState();
}

class _NumberApplicationFieldState extends State<NumberApplicationField> {
  late FocusNode _node;



  @override
  void initState() {
    super.initState();
    _node = FocusNode();
    _node.requestFocus();
  }


  @override
  void dispose() {
    super.dispose();
    _node.unfocus();
    _node.dispose();
  } @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
      physics: const BouncingScrollPhysics(),
      children: [
        Text(
          widget.config.label ?? "",
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
        const SizedBox(
          height: 25,
        ),
        TextFormField(
          focusNode: _node,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          initialValue: widget.config.value?.toString() ?? widget.config.defaultValue?.toString(),
          validator: (val) {
            if (val == null || val.isEmpty) {
              return "${widget.config.label} is required";
            } else {
              return null;
            }
          },
          onChanged: (val) {
            if(val.isNotEmpty){
              widget.config.value = int.parse(val);
            }else {
              widget.config.value = null;
            }
            application.notify();
          },
          decoration: InputDecoration(
            hintText: widget.config.placeholder,

          ),
        )
      ],
    );
  }
}
