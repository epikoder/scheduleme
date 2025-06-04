import 'package:flutter/material.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class AppointmentByIdScreen extends StatelessWidget {
  const AppointmentByIdScreen({
    super.key,
    required this.appointmentId,
  });
  final String appointmentId;

  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Appointment"),
        body: <Widget>[].toColumn(),
      ),
    );
  }
}
