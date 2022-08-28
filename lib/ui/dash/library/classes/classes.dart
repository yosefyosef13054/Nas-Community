import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/dash/library/classes/components/class_card.dart';
import 'package:provider/provider.dart';

class ClassTab extends StatelessWidget {
  const ClassTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    if(dash.libraryClasses.isNotEmpty){
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: dash.libraryClasses.map((e) => ClassCard(videoClass: e,)).toList(),
        ),
      );
    }else {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        child:EmptyState(),
      );
    }
  }
}
