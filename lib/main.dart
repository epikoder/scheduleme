import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/core/core_widget.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/theme.dart';
import 'package:theme_manager/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.init();
  
  runApp(
    ProviderScope(
      child: ThemeManager(
        defaultBrightnessPreference: BrightnessPreference.system,
        data: (brightness) => ThemeData(
          primarySwatch: Colors.blue,
          brightness: brightness,
        ),
        themedBuilder: (_, __) => const MyApp(),
      ),
    ),
  );
}

class MyApp extends CoreStatelessWidget {
  const MyApp({super.key});

  @override
  Widget createAndroidWidget(BuildContext context) {
    return MaterialApp(
      title: 'ScheduleMe',
      theme: AppTheme.materialTheme(context),
      initialRoute: "/splash-screen",
      routes: NavigationService.routes,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: NavigationService.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return CupertinoApp(
      title: "ScheduleMe",
      theme: AppTheme.cupertinoTheme(context),
      initialRoute: "/splash-screen",
      routes: NavigationService.routes,
      navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: NavigationService.onGenerateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
