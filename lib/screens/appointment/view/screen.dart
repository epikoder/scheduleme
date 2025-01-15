import 'package:flutter/material.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:styled_widget/styled_widget.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        [
          Styled.text("Appointments").padding(vertical: 10),
        ].toColumn(),
        const FloatingBackButton(),
      ].toStack(),
    );
  }
}
