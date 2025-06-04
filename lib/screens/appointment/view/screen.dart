import 'package:flutter/material.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Appointments"),
        body: <Widget>[].toColumn(),
      ),
    );
  }
}
