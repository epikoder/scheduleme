import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/theme.dart';
import 'package:scheduleme/utils/core/method.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTheme.init();

  applicationMethod.initialize();

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
    return createAndroidWidget(context);
  }
}
