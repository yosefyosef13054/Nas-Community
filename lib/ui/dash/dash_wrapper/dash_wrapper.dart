import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/community/community/community.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/ui/dash/community_view/community_view.dart';
import 'package:nas_academy/ui/dash/discover/discover.dart';
import 'package:provider/provider.dart';
import 'dart:developer';


class DashWrapper extends StatelessWidget {
  const DashWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dash = Provider.of<DashProvider>(context);
    final todo = Provider.of<TodoProvider>(context);
    return Scaffold(
      body: PageView(
        controller: dash.communitiesPageController,
        onPageChanged: (i){
          dash.onCommunityChange(i);
          try{
            todo.dis();
            dash.membersTabController.index = 0;
          }catch (e){
            log("NOTHING HERE ...");
          }
        },
        physics: const NeverScrollableScrollPhysics(),
        children:  _list(dash),
      ),
    );
  }
}


List<Widget> _list (DashProvider dash){
  List<Widget> _children = [];
  for (Community community in dash.communities) {
    _children.add(CommunityView(communityCode: community.code!));
  }
  _children.add(const DiscoverScreen());
  return _children;
}
