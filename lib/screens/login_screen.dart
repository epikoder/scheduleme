import 'package:flutter/material.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/core/button.dart';
import 'package:scheduleme/core/input.dart';
import 'package:scheduleme/core/scaffold.dart';
import 'package:scheduleme/core/screen.dart';
import 'package:scheduleme/core/theme.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/theme.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CoreTheme(
        themeData: AppTheme.materialThemeLight(),
        cupertinoThemeData: AppTheme.cupertinoThemeLight(),
        child: CoreScaffold(
          body: CoreScreen(
            child: <Widget>[
              const Logo(),
              [
                Styled.text("Login").textColor(Colors.black),
                Styled.text("sign in to continue").textColor(Colors.black54),
              ].toColumn(
                separator: const SizedBox(
                  height: 10,
                ),
              ),
              [
                CoreInput(
                  label: Styled.text("Email"),
                  placeholder: "acme@domain.com",
                ),
                CoreInput(
                  label: Styled.text("Password"),
                  placeholder: "********",
                ),
                CoreButton(child: Styled.text("Log in")),
                [
                  Styled.text("Don't have an account yet?")
                      .textColor(Colors.black),
                  Styled.text("sign up")
                      .textColor(Colors.black54)
                      .ripple()
                      .gestures(onTap: () => Compass.push("/sign-up")),
                ].toRow(
                    separator: const SizedBox(
                  width: 20,
                )),
              ].toColumn(
                separator: const SizedBox(
                  height: 10,
                ),
              ),
            ]
                .toColumn(
                  separator: const SizedBox(
                    height: 30,
                  ),
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                )
                .padding(horizontal: 10),
          ),
        )).safeArea();
  }
}
