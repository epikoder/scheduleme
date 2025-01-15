import 'package:flutter/material.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CoreScaffold(
      body: <Widget>[
        const Logo(),
        [
          Styled.text("Signup").textColor(Colors.black),
          Styled.text("create an account").textColor(Colors.black54),
        ].toColumn(),
        [
          CoreInput(
            label: Styled.text("Email"),
            placeholder: "acme@domain.com",
          ),
          CoreInput(
            label: Styled.text("Password"),
            placeholder: "********",
          ),
          CoreInput(
              label: Styled.text("Confirm password"),
              placeholder: "********",
              validator: (str) {
                return null;
              }),
          CoreButton(child: Styled.text("Signup")),
          [
            Styled.text("Already have an account?")
                .textColor(Colors.black54)
                .fontSize(13),
            TextButton(
              onPressed: Compass.pop,
              child: Styled.text("Login Here")
                  .fontSize(12)
                  .textColor(Colors.black),
            ),
          ].toWrap(
            spacing: 20,
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
          ),
        ].toColumn(separator: const SizedBox(height: 10)),
      ]
          .toColumn(
              separator: const SizedBox(height: 30),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center)
          .padding(horizontal: 10),
    ).safeArea();
  }
}
