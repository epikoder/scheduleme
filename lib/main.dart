import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/constants/api_url.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:scheduleme/services/auth/auth.login.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/theme.dart';
import 'package:scheduleme/utils/logger.dart';
import 'package:scheduleme/utils/net_tools.dart';
import 'package:http/http.dart' as http;
import 'package:scheduleme/utils/type_registry.dart';

part 'main.mock.dart';
part 'main.types.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.init();

  Client.instance.isMockingRequest = true;
  ensureMockServerWhenTesting();
  registerConstructors();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends CoreStatelessWidget {
  const MyApp({super.key});

  @override
  Widget createAndroidWidget(BuildContext context) {
    return MaterialApp(
      title: 'ScheduleMe',
      theme: AppTheme.materialThemeLight(),
      initialRoute: "/splash-screen",
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: NavigationService.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return CupertinoApp(
      title: "ScheduleMe",
      theme: AppTheme.cupertinoThemeLight(),
      initialRoute: "/splash-screen",
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: NavigationService.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
