import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class MemosScreen extends ConsumerStatefulWidget {
  const MemosScreen({super.key});

  @override
  MemosScreenState createState() => MemosScreenState();
}

class MemosScreenState extends ConsumerState<MemosScreen> {
  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Memos"),
        body: <Widget>[].toColumn(),
      ),
    );
  }
}
