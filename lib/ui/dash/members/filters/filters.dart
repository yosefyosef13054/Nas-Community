import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/ui/dash/members/filters/components/filters_body_wrapper.dart';
import 'package:provider/provider.dart';



class FiltersSheet extends StatelessWidget {
  const FiltersSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    return ClipRRect(
      borderRadius: members.borderRadius(),
      child: const Material(
          child: AnimatedSize(
            reverseDuration: Duration(milliseconds: 200),
            duration: Duration(milliseconds: 200),
            child: FiltersBodyWrapper(),
          )
      ),
    );
  }
}
