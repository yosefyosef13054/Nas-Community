
import 'package:auto_route/auto_route.dart';
import 'package:nas_academy/ui/dash/settings/help_desk/help_desk.dart';
import 'package:nas_academy/ui/dash/settings/manage_account/manage_account.dart';
import 'package:nas_academy/ui/dash/settings/settings_page.dart';
import 'package:nas_academy/ui/splash/splash.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Splash, initial: true),
    AutoRoute(page: ManageAccountScreen),
    AutoRoute(page: HelpDeskScreen),
    AutoRoute(page: SettingPage),
  ],
)
class $Router{
  
}