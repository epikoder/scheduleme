import 'package:flutter/cupertino.dart';
import 'package:scheduleme/screens/appointment/create/screen.dart';
import 'package:scheduleme/screens/appointment/view/screen.dart';
import 'package:scheduleme/screens/dashboard/screen.dart';
import 'package:scheduleme/screens/login_screen.dart';
import 'package:scheduleme/screens/onboarding/organisation_setup_screen.dart';
import 'package:scheduleme/screens/register_screen.dart';
import 'package:scheduleme/screens/spaces/manage/customize_appointment.dart';
import 'package:scheduleme/screens/splash.screen.dart';
import 'package:scheduleme/screens/story_board.screen.dart';

abstract class NavigationService {
  static final navigationKey = GlobalKey<NavigatorState>();

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        "/splash-screen" =>
          CupertinoPageRoute(builder: (context) => const SplashScreen()),
        "/login" =>
          CupertinoPageRoute(builder: (context) => const LoginScreen()),
        "/register" =>
          CupertinoPageRoute(builder: (context) => const RegisterScreen()),

        // authenticated routes
        "/onboarding/organisation" =>
          CupertinoPageRoute(builder: (_) => const OrganisationSetupScreen()),
        "/dashboard" =>
          CupertinoPageRoute(builder: (context) => DashboardScreen()),
        "/appointments/view" =>
          CupertinoPageRoute(builder: (_) => const AppointmentScreen()),
        "/appointments/create" =>
          CupertinoPageRoute(builder: (_) => CreateAppointment()),
        "/spaces/manage/customize_appointment" =>
          CupertinoPageRoute(builder: (_) => const CustomizeAppointment()),
        "/story-board" => FadeTransitionRoute(page: const StoryBoardScreen()),
        _ => null,
      };
}

class FadeTransitionRoute extends PageRouteBuilder {
  final Widget page;

  FadeTransitionRoute({required this.page})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
}

abstract class Compass {
  static Future<T?> push<T extends Object?>(
    String route, {
    Object? arguments,
  }) =>
      Navigator.pushNamed(
          NavigationService.navigationKey.currentContext!, route,
          arguments: arguments);

  static Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    String route, {
    Object? arguments,
  }) =>
      Navigator.pushReplacementNamed(
          NavigationService.navigationKey.currentContext!, route,
          arguments: arguments);

  static pop<T extends Object?>([Object? result]) =>
      Navigator.pop(NavigationService.navigationKey.currentContext!, result);
}
