import 'package:flutter/material.dart';
import 'package:scheduleme/core/button.dart';
import 'package:scheduleme/core/input.dart';
import 'package:scheduleme/core/scaffold.dart';
import 'package:scheduleme/core/theme.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/theme.dart';
import 'package:scheduleme/utils/assets.dart';
import 'package:styled_widget/styled_widget.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CoreTheme(
        themeData: AppTheme.materialThemeLight(),
        cupertinoThemeData: AppTheme.cupertinoThemeLight(),
        child: CoreScaffold(
          body: <Widget>[
            Image.asset(
              Assets.logo,
              height: 200,
            ),
            [
              Styled.text("Signup").textColor(Colors.black),
              Styled.text("create an account").textColor(Colors.black54),
            ].toColumn(),
            [
              CoreInput(
                label: Styled.text("Firstname"),
                placeholder: "Acme",
              ),
              CoreInput(
                label: Styled.text("Lastname"),
                placeholder: "Joe",
              ),
              CoreInput(
                label: Styled.text("Email"),
                placeholder: "acme@domain.com",
              ),
              CoreInput(
                label: Styled.text("Password"),
                placeholder: "********",
              ),
              CoreButton(child: Styled.text("Signup")),
              [
                Styled.text("Already have an account?").textColor(Colors.black),
                Styled.text("login here")
                    .textColor(Colors.black54)
                    .ripple()
                    .gestures(onTap: Compass.pop),
              ].toRow(
                  separator: const SizedBox(
                width: 20,
              )),
            ].toColumn(),
          ]
              .toColumn(crossAxisAlignment: CrossAxisAlignment.center)
              .padding(horizontal: 10),
        )).safeArea();
  }
}
