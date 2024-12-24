import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core/core_widget.dart';

class CoreTheme extends CoreStatelessWidget {
  const CoreTheme({
    super.key,
    this.themeData,
    this.cupertinoThemeData,
    required this.child,
  });
  final ThemeData? themeData;
  final CupertinoThemeData? cupertinoThemeData;
  final Widget child;

  @override
  Widget createAndroidWidget(BuildContext context) {
    assert(!Platform.isIOS && themeData != null);
    return Theme(data: themeData!, child: child);
  }

  @override
  Widget createIosWidget(BuildContext context) {
    assert(Platform.isIOS && cupertinoThemeData != null);
    return CupertinoTheme(data: cupertinoThemeData!, child: child);
  }
}
