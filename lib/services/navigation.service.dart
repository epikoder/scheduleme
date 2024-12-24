import 'package:flutter/material.dart';
import 'package:scheduleme/screens/login_screen.dart';
import 'package:scheduleme/screens/splash.screen.dart';
import 'package:scheduleme/screens/story_board.screen.dart';

abstract class NavigationService {
  static final navigationKey = GlobalKey<NavigatorState>();
  static Map<String, Widget Function(BuildContext)> routes = {
    "/splash-screen": (context) => const SplashScreen(),
    "/login": (context) => const LoginScreen(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        Navigator.defaultRouteName =>
          FadeTransitionRoute(page: const StoryBoardScreen()),
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
