import 'package:flutter/material.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingScreen extends CoreStatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget createAndroidWidget(BuildContext context) {
    return [
      Styled.text("Settings"),
    ].toColumn().scrollable().padding(horizontal: 10);
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return createAndroidWidget(context);
  }
}
