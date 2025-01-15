import 'package:flutter/material.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class CustomizeAppointment extends StatelessWidget {
  const CustomizeAppointment({super.key});

  @override
  Widget build(BuildContext context) {
    return CoreScreen(
        child: Scaffold(
      body: <Widget>[
        <Widget>[
          Styled.text("Choose Application").padding(vertical: 10),
          const Row(),
        ]
            .toColumn(
              separator: const SizedBox(
                height: 20,
              ),
            )
            .padding(all: 10)
            .scrollable(),
        const FloatingBackButton()
      ].toStack(),
    ));
  }
}
