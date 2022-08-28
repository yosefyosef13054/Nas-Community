import 'package:flutter/material.dart';
import 'package:nas_academy/core/modules/user/user.dart';
import 'package:nas_academy/core/providers/dash/dash_provider.dart';
import 'package:nas_academy/core/providers/live_session/live_session_provider.dart';
import 'package:nas_academy/core/services/notification_service.dart';
import 'package:nas_academy/ui/auth/welcome/welcome_page.dart';
import 'package:nas_academy/ui/dash/dash.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  @override
  void initState() {
    super.initState();
    final dash = Provider.of<DashProvider>(context, listen: false);
    final liveSessions = Provider.of<LiveSessonProvider>(context, listen: false);
    NotificationService(context: context, dash: dash, sessoin: liveSessions).init();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User?>(context);
    if (user == null) {
      return const WelcomePage();
    } else {
      return const Dash();
    }
  }
}
