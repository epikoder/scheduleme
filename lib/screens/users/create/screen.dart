import 'package:flutter/material.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class CreateUserScreen extends CoreStatelessWidget {
  const CreateUserScreen({super.key});

  @override
  Widget createAndroidWidget(BuildContext context) {
    return CoreScaffold(body: CoreScreen(child: <Widget>[].toColumn()));
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return createAndroidWidget(context);
  }
}
