import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CoreStatelessWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  const CoreStatelessWidget({super.key});

  I createIosWidget(BuildContext context);
  A createAndroidWidget(BuildContext context);

  @override
  Widget build(BuildContext context) => switch (Platform.isIOS) {
        true => createIosWidget(context),
        _ => createAndroidWidget(context)
      };
}

abstract class CoreStatefulWidget<PS extends CoreWidgetState>
    extends StatefulWidget {
  const CoreStatefulWidget({super.key});

  @override
  PS createState();
}

abstract class CoreWidgetState<W extends StatefulWidget> extends State<W> {
  Widget createIosWidget(BuildContext context);
  Widget createAndroidWidget(BuildContext context);

  @override
  Widget build(BuildContext context) => switch (Platform.isIOS) {
        true => createIosWidget(context),
        _ => createAndroidWidget(context)
      };
}
