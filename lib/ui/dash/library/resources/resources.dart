import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/ui/common/empty_state.dart';
import 'package:nas_academy/ui/dash/library/resources/components/resource_card.dart';
import 'package:provider/provider.dart';

class ResourcesTab extends StatelessWidget {
  const ResourcesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    if(dash.libraryVideoPreviews.isNotEmpty){
      return Padding(
        padding: const EdgeInsets.all(25.0),
        child: Wrap(
          runSpacing: 10,
          spacing: 10,
          children: dash.libraryResourcePreviews.map((e) => ResourceCard(preview: e,)).toList(),
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
