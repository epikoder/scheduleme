import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:option_result/option.dart';
import 'package:scheduleme/screens/account_setup_screen.dart';
import 'package:scheduleme/screens/appointment/create/screen.dart';
import 'package:scheduleme/screens/appointment/view/appointmendt_id_screen.dart';
import 'package:scheduleme/screens/appointment/view/screen.dart';
import 'package:scheduleme/screens/dashboard/screen.dart';
import 'package:scheduleme/screens/email_verification_screen.dart';
import 'package:scheduleme/screens/login_screen.dart';
import 'package:scheduleme/screens/memos/screen.dart';
import 'package:scheduleme/screens/onboarding/organisation_setup_screen.dart';
import 'package:scheduleme/screens/register_screen.dart';
import 'package:scheduleme/screens/reminders/screen.dart';
import 'package:scheduleme/screens/settings/screen.dart';
import 'package:scheduleme/screens/spaces/manage/customize_appointment_form.dart';
import 'package:scheduleme/screens/spaces/manage/screen.dart';
import 'package:scheduleme/screens/splash.screen.dart';
import 'package:scheduleme/screens/story_board.screen.dart';
import 'package:scheduleme/screens/users/invite/invite_form_edit.dart';
import 'package:scheduleme/screens/users/invite/screen.dart';

String? getArg(RouteSettings settings, String key) {
  final String? value =
      settings.arguments != null ? (settings.arguments as dynamic)["id"] : null;
  return value;
}

abstract class NavigationService {
  static final navigationKey = GlobalKey<NavigatorState>();

  static BuildContext get context =>
      NavigationService.navigationKey.currentContext!;

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) =>
      switch (settings.name) {
        "/story-board" => FadeTransitionRoute(page: const StoryBoardScreen()),
        "/splash-screen" =>
          CupertinoPageRoute(builder: (context) => const SplashScreen()),
        "/login" => CupertinoPageRoute(
            builder: (_) => LoginScreen(
                  email: getArg(settings, "email"),
                )),
        "/register" => CupertinoPageRoute(
            builder: (_) => RegisterScreen(
                  email: getArg(settings, "email"),
                )),

        //
        "/email-verification" => getArg(settings, "email") == null
            ? null
            : CupertinoPageRoute(
                builder: (_) => EmailVerificationScreen(
                      email: getArg(settings, "email")!,
                    )),

        /// authenticated routes
        "/account-setup" =>
          CupertinoPageRoute(builder: (_) => const AccountSetupScreen()),
        "/onboarding/organisation" =>
          CupertinoPageRoute(builder: (_) => const OrganisationSetupScreen()),
        "/dashboard" =>
          CupertinoPageRoute(builder: (_) => const DashboardScreen()),
        "/appointments" =>
          CupertinoPageRoute(builder: (_) => const AppointmentScreen()),
        "/appointments/view" => getArg(settings, "id") == null
            ? null
            : CupertinoPageRoute(
                builder: (_) => AppointmentByIdScreen(
                    appointmentId: getArg(settings, "id")!),
              ),
        "/appointments/create" =>
          CupertinoPageRoute(builder: (_) => const CreateAppointment()),
        "/spaces/manage" =>
          CupertinoPageRoute(builder: (_) => const ManageAppointmentForms()),
        "/spaces/manage/customize_appointment" => getArg(settings, "id") == null
            ? null
            : CupertinoPageRoute(
                builder: (_) => CustomizeAppointmentFormScreen(
                      appointmentFormId: getArg(settings, "id")!,
                    )),
        "/settings" =>
          CupertinoPageRoute(builder: (_) => const SettingScreen()),

        // Users
        "/users/invite" =>
          CupertinoPageRoute(builder: (_) => const UserInviteScreen()),
        "/users/invite/edit" =>
          CupertinoPageRoute(builder: (_) => const UserInviteFormEditScreen()),

        // Reminders
        "/reminders" =>
          CupertinoPageRoute(builder: (_) => const RemindersScreen()),

        // Memos
        "/memos" => CupertinoPageRoute(builder: (_) => const MemosScreen()),
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

  static popAndPushNamed(
    String route, {
    Object? arguments,
  }) =>
      Navigator.popAndPushNamed(
          NavigationService.navigationKey.currentContext!, route,
          arguments: arguments);

  static popUntil(bool Function(Route<dynamic>) predicate) =>
      Navigator.popUntil(
          NavigationService.navigationKey.currentContext!, predicate);
}
