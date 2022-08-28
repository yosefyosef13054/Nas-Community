import 'package:flutter/material.dart';
import 'package:nas_academy/core/providers/dash/members.dart';
import 'package:nas_academy/ui/dash/members/filters/components/followers_filter.dart';
import 'package:nas_academy/ui/dash/members/filters/components/location_filter_body.dart';
import 'package:nas_academy/ui/dash/members/filters/components/main_body.dart';
import 'package:nas_academy/ui/dash/members/filters/components/member_role_filter.dart';
import 'package:nas_academy/ui/dash/members/filters/components/skills_filter.dart';
import 'package:nas_academy/ui/dash/members/filters/components/social_platform_filter.dart';
import 'package:provider/provider.dart';


class FiltersBodyWrapper extends StatelessWidget {
  const FiltersBodyWrapper({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final members = Provider.of<MembersProvider>(context);
    switch (members.filtersIndex){
      case 0 : return const MainFiltersBody();
      case 1 : return const MemberRoleFiltersBody();
      case 2 : return const LocationFiltersBody();
      case 3 : return const SkillsFiltersBody();
      case 4 : return const SocialPlatformFiltersBody();
      case 5 : return const FollowersCountFiltersBody();
      default : return const MainFiltersBody();
    }
  }
}
