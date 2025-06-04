import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/services/auth/auth.register.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/toast.dart';
import 'package:scheduleme/utils/validator.dart';
import 'package:styled_widget/styled_widget.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key, this.email});

  final String? email;
  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends ConsumerState<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController.text = widget.email ?? "";
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final registerState = ref.watch(registerProvider);
    ref.listen(registerProvider, (_, value) {
      switch (value) {
        case AsyncError(:MethodError error):
          showToast(error.getMessage, context: context);
          break;
        case AsyncData(:final value):
          if (value.isSome()) {
            showToast("Account created successfully..", context: context);
            Future.delayed(
                const Duration(seconds: 1),
                () => Compass.popAndPushNamed("/email-verification",
                    arguments: {"email": emailController.text}));
            return;
          }
          break;
      }
    });

    return CoreScaffold(
      body: <Widget>[
        const Logo(),
        [
          Styled.text("Signup").textColor(Colors.black),
          Styled.text("create an account").textColor(Colors.black54),
        ].toColumn(),
        Form(
          key: formKey,
          child: [
            CoreInput(
              label: Styled.text("Email"),
              circularBorderRadius: 30,
              placeholder: "acme@domain.com",
              controller: emailController,
              validator: (str) => str == null || str.isEmpty
                  ? "email is required"
                  : isEmailValid(str)
                      ? null
                      : "email is invalid",
            ),
            CoreInput(
              label: Styled.text("Password"),
              circularBorderRadius: 30,
              placeholder: "********",
              obscureText: true,
              controller: passwordController,
              validator: (str) => str == null
                  ? "password is required"
                  : str.isEmpty
                      ? "password is required"
                      : str.length < 8
                          ? "password is too short: min. 8"
                          : isPasswordValid(str)
                              ? null
                              : "password is invalid: a-Z 0-9 @-_{}[]",
            ),
            CoreInput(
              label: Styled.text("Confirm password"),
              circularBorderRadius: 30,
              placeholder: "********",
              obscureText: true,
              controller: confirmPasswordController,
              validator: (str) =>
                  str == passwordController.text ? null : "password mismatch",
            ),
            switch (registerState) {
              AsyncError(:MethodError value) => Styled.text(value.getMessage)
                  .fontSize(12)
                  .textColor(Colors.redAccent),
              _ => const SizedBox()
            },
            CoreButton(
              onPressed: () {
                if (!formKey.currentState!.validate()) return;
                ref.read(registerProvider.notifier).registerWithCredentials(
                    emailController.text, passwordController.text);
              },
              child: switch (registerState) {
                AsyncLoading() => [
                    Styled.text("Signup"),
                    const CupertinoActivityIndicator()
                  ].toRow(
                    separator: const SizedBox(
                      width: 10,
                    ),
                    mainAxisSize: MainAxisSize.min,
                  ),
                _ => Styled.text("Signup"),
              },
            ),
          ].toColumn(
            separator: const SizedBox(height: 10),
          ),
        ),
        [
          Styled.text("Already have an account?")
              .textColor(Colors.black54)
              .fontSize(13),
          TextButton(
            onPressed: Compass.pop,
            child:
                Styled.text("Login Here").fontSize(12).textColor(Colors.black),
          ),
        ].toWrap(
          spacing: 20,
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
        )
      ]
          .toColumn(
              separator: const SizedBox(height: 30),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center)
          .padding(horizontal: 20),
    );
  }
}
