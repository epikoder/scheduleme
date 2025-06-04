import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class RemindersScreen extends ConsumerStatefulWidget {
  const RemindersScreen({super.key});

  @override
  RemindersScreenState createState() => RemindersScreenState();
}

class RemindersScreenState extends ConsumerState<RemindersScreen> {
  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Reminders"),
        body: <Widget>[].toColumn(),
      ),
    );
  }
}
