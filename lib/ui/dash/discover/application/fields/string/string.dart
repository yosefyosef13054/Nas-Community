import "package:flutter/material.dart";
import 'package:nas_academy/core/modules/application/application_config.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:provider/provider.dart';



class StringApplicationField extends StatefulWidget {
  const StringApplicationField({Key? key, required this.config}) : super(key: key);
  final ApplicationConfig config;
  @override
  State<StringApplicationField> createState() => _StringApplicationFieldState();
}

class _StringApplicationFieldState extends State<StringApplicationField> {
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
    }
  @override
  Widget build(BuildContext context) {
    final application = Provider.of<ApplicationProvider>(context);
    final bool isName = widget.config.fieldName!.toLowerCase().contains("name");
    final bool isLink = widget.config.fieldName!.toLowerCase().contains("link");
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
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
          keyboardType: isName? TextInputType.name : isLink? TextInputType.url : null,
          textCapitalization: isName? TextCapitalization.words : TextCapitalization.none,
          autofillHints: isName? const [
            AutofillHints.name,
            AutofillHints.givenName,
            AutofillHints.familyName,
            AutofillHints.username
          ] : [],
          initialValue: widget.config.value?.toString() ?? widget.config.defaultValue?.toString(),
          validator: (val) {
            if (widget.config.value == null || widget.config.value!.isEmpty) {
              return "${widget.config.label} is required";
            } else {
              return null;
            }
          },
          onChanged: (val) {
            widget.config.value = val;
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
