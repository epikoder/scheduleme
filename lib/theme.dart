import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:theme_manager/theme_manager.dart';
import 'package:json_theme_plus/json_theme_plus.dart';

abstract class AppTheme {
  static late ThemeData __themeLight;
  static Future<void> init() async {
    final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
    final themeJson = jsonDecode(themeStr);
    AppTheme.__themeLight = ThemeDecoder.decodeThemeData(themeJson)!;
  }

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

  static ThemeData materialThemeLight() => AppTheme.__themeLight;

  static ThemeData materialThemeDark() => ThemeData(
        primaryColor: Colors.black,
        buttonTheme: const ButtonThemeData(
          padding: EdgeInsets.symmetric(horizontal: 50),
          colorScheme: ColorScheme(
              brightness: Brightness.dark,
              primary: Colors.black26,
              onPrimary: Colors.white70,
              secondary: Colors.black26,
              onSecondary: Colors.white60,
              error: Colors.redAccent,
              onError: Colors.white70,
              surface: Colors.black87,
              onSurface: Colors.white60),
        ),
      );

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
