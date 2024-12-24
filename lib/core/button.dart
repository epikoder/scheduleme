import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core/core_widget.dart';

class CoreButton extends CoreStatelessWidget {
  const CoreButton({
    super.key,
    required this.child,
  });
  final Widget child;

  @override
  Widget createAndroidWidget(BuildContext context) {
    return ElevatedButton(onPressed: () {}, child: child);
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return CupertinoButton.filled(child: child, onPressed: () {});
  }
}
