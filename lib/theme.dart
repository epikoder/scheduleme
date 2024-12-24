import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:theme_manager/theme_manager.dart';

abstract class AppTheme {
  static Brightness getBrightness(BuildContext context) =>
      switch (ThemeManager.of(context).state.brightnessPreference) {
        BrightnessPreference.system =>
          MediaQuery.of(context).platformBrightness,
        BrightnessPreference.dark => Brightness.dark,
        BrightnessPreference.light => Brightness.light,
      };

  static ThemeData materialTheme(BuildContext context) =>
      switch (getBrightness(context)) {
        Brightness.dark => materialThemeDark(),
        Brightness.light => materialThemeLight(),
      };

  static ThemeData materialThemeLight() => ThemeData();
  static ThemeData materialThemeDark() => ThemeData();

  static CupertinoThemeData cupertinoTheme(BuildContext context) =>
      switch (getBrightness(context)) {
        Brightness.dark => cupertinoThemeDark(),
        Brightness.light => cupertinoThemeLight(),
      };

  static CupertinoThemeData cupertinoThemeDark() => const CupertinoThemeData(
        primaryColor: Colors.black,
      );
      
  static CupertinoThemeData cupertinoThemeLight() =>
      const CupertinoThemeData(primaryColor: Colors.white);
}
