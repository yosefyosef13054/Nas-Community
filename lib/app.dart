import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:nas_academy/core/api/category/category.dart';
import 'package:nas_academy/core/local_db/user/user_local_db.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/application/application_provider.dart';
import 'package:nas_academy/core/providers/boarding/intro.dart';
import 'package:nas_academy/core/providers/boarding/recommendations.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/dash/profile_provider.dart';
import 'package:nas_academy/core/providers/discover/discover.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/providers/todo/todo_provider.dart';
import 'package:nas_academy/core/utils/theme.dart';
import 'package:nas_academy/ui/splash/splash.dart';
import 'package:provider/provider.dart';

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {


  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IntroProvider()),
        ChangeNotifierProvider(create: (context) => RecommendationsProvider(CategoryApi())),
        ChangeNotifierProvider(create: (context) => DashProvider()),
        ChangeNotifierProvider(create: (context) => LiveSessonProvider()),
        ChangeNotifierProvider(create: (context) => TodoProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
        ChangeNotifierProvider(create: (context) => DiscoverProvider()),
        ChangeNotifierProvider(create: (context) => ApplicationProvider()),
        FutureProvider<User?>.value(
            value: UserLocalDB.currentUser(),
            initialData: null,
            updateShouldNotify: (val1, val2) => true),
      ],
      child: KeyboardDismissOnTap(
        child: MaterialApp(
            // navigatorKey: Navigate.navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            title: 'Nas Academy',
            theme: MyTheme.light,
            darkTheme: MyTheme.dark,
            home: const Splash()),
      ),
    );
  }
}
