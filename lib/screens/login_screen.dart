import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/services/auth/auth.login.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/utils/assets.dart';
import 'package:scheduleme/utils/logger.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final providerState = ref.watch(findAuthMethodProvider);
    ref.listen(loginProvider, (_, value) {
      switch (value) {
        case AsyncError(:final error, :final stackTrace):
          logger.d(error, stackTrace: stackTrace);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Styled.text("Something went wrong")));
          break;
        case AsyncData(:final value):
          if (value != null) {
            Compass.pushReplacement("/dashboard");
            return;
          }
          break;
      }
    });

    ref.listen(findAuthMethodProvider, (_, value) {
      switch (value) {
        case AsyncError(:final error, :final stackTrace):
          logger.d(error, stackTrace: stackTrace);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Styled.text("Something went wrong")));
          break;
        case AsyncData(:final value):
          if (value != AuthMethod.none) {
            if (value == AuthMethod.none) {
              Compass.push("/register",
                  arguments: {"email": emailController.value});
              return;
            }
            return;
          }
          break;
      }
    });

    return CoreScaffold(
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
            [
              CoreInput(
                label: Styled.text("Email"),
                placeholder: "acme@domain.com",
                controller: emailController,
              ),
              if (providerState.value == AuthMethod.credentials)
                CoreInput(
                  label: Styled.text("Password"),
                  placeholder: "********",
                  controller: passwordController,
                  obscureText: true,
                ),
              CoreButton(
                disabled: loginState.isLoading ||
                    providerState.isLoading ||
                    providerState.value == AuthMethod.google,
                onPressed: () async {
                  if (emailController.text.isEmpty) return;
                  switch (providerState.value) {
                    case null:
                    case AuthMethod.none:
                      {
                        await ref
                            .read(findAuthMethodProvider.notifier)
                            .findProvider(
                              emailController.text,
                            );
                        break;
                      }
                    case AuthMethod.google:
                      break;
                    default:
                      ref.read(loginProvider.notifier).loginWithCredendials(
                            emailController.text,
                            passwordController.text,
                          );
                  }
                },
                child: switch (providerState) {
                  AsyncLoading() => [
                      Styled.text("Continue"),
                      const CupertinoActivityIndicator(
                        radius: 8,
                      ),
                    ].toRow(
                      mainAxisSize: MainAxisSize.min,
                      separator: const SizedBox(
                        width: 10,
                      ),
                    ),
                  _ => switch (providerState.value) {
                      AuthMethod.credentials => switch (loginState) {
                          AsyncLoading() => [
                              Styled.text("Log in"),
                              const CupertinoActivityIndicator(
                                radius: 8,
                              )
                            ].toRow(
                              mainAxisSize: MainAxisSize.min,
                              separator: const SizedBox(
                                width: 10,
                              ),
                            ),
                          _ => Styled.text("Log in"),
                        },
                      AuthMethod.google => Styled.text("Continue with Google"),
                      _ => Styled.text("Continue")
                    },
                },
              ),
            ].toColumn(
                separator: const SizedBox(
              height: 10,
            )),
            [
              Styled.text("Don't have an account yet?")
                  .textColor(Colors.black54)
                  .fontSize(13),
              TextButton(
                onPressed: () => Compass.push("/register"),
                child:
                    Styled.text("sign up").fontSize(12).textColor(Colors.black),
              ),
            ].toWrap(
              spacing: 20,
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
            ),
          ].toColumn(
            separator: const SizedBox(
              height: 10,
            ),
          ),
          const SizedBox(
            height: 20,
            width: 1,
          ).backgroundColor(
            ExtColor.buttonColor,
          ),
          _SocialLoginButton(
            icon: Image.asset(
              Assets.google,
              fit: BoxFit.cover,
              height: 30,
              width: 30,
            ),
            disabled: true,
            onPressed: () {},
            child: Styled.text("Sign in with Google").textColor(Colors.white),
          ),
        ]
            .toColumn(
              separator: const SizedBox(
                height: 20,
              ),
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            )
            .padding(horizontal: 10),
      ),
    ).safeArea();
  }
}

class _SocialLoginButton extends ConsumerWidget {
  const _SocialLoginButton({
    required this.child,
    required this.icon,
    required this.onPressed,
    // ignore: unused_element
    this.backgroundColor = Colors.red,
    this.disabled,
  });

  final Widget child;
  final Widget icon;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final bool? disabled;

  bool get _isDisabled => disabled == null || disabled!;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        ),
        backgroundColor:
            WidgetStatePropertyAll(_isDisabled ? Colors.grey : backgroundColor),
      ),
      onPressed: _isDisabled ? null : onPressed,
      child: [
        icon,
        child,
      ]
          .toRow(
              separator: const SizedBox(
                width: 20,
              ),
              mainAxisAlignment: MainAxisAlignment.center)
          .padding(vertical: 5)
          .width(250),
    );
  }
}
