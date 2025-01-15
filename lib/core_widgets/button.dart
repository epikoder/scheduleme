import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';

class CoreButton extends CoreStatelessWidget {
  const CoreButton({
    super.key,
    required this.child,
    this.onPressed,
    this.disabled = false,
  });
  final Widget child;
  final void Function()? onPressed;
  final bool disabled;

  @override
  Widget createAndroidWidget(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      child: child,
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return CupertinoButton.filled(onPressed: onPressed, child: child);
  }
}
