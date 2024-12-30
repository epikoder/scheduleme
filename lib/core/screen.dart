import 'package:flutter/material.dart';
import 'package:scheduleme/core/core_widget.dart';

class CoreScreen extends CoreStatelessWidget {
  const CoreScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget createAndroidWidget(BuildContext context) {
    return Material(
      child: child,
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return child;
  }
}
