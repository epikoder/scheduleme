import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:option_result/option.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/services/auth/auth.login.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
import 'package:scheduleme/utils/assets.dart';
import 'package:scheduleme/utils/toast.dart';
import 'package:scheduleme/utils/validator.dart';
import 'package:styled_widget/styled_widget.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key, this.email});
  final String? email;

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController.text = widget.email ?? "";
    super.initState();
  }

  @override
  dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  pushToRegister() {
    Compass.push("/register", arguments: {"email": emailController.text})
        .then((result) {
      if (result != null && (result as dynamic)["email"] != null) {
        emailController.text = (result as dynamic)["email"];
        ref
            .read(findAuthMethodProvider.notifier)
            .useAuthMethod(AuthMethod.credentials);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginProvider);
    final providerState = ref.watch(findAuthMethodProvider);
    ref.listen(loginProvider, (_, value) {
      switch (value) {
        case AsyncError(:MethodError error):
          showToast(error.getMessage, context: context);
          break;
        case AsyncData(:final value):
          if (value.isSome()) {
            final response = value.unwrap();
            switch (response.code) {
              case null:
                Compass.pushReplacement("/dashboard");
              case 2001:
                Compass.pushReplacement("/email-verification",
                    arguments: {"email": emailController.text});
              case 2002:
                Compass.pushReplacement("/account-setup");
            }

            return;
          }
          break;
      }
    });

    ref.listen(findAuthMethodProvider, (_, value) {
      switch (value) {
        case AsyncData(:final value):
          {
            if (value.isNone()) {
              pushToRegister();
            }
          }
        case AsyncError(:MethodError error):
          showToast(error.getMessage, context: context);
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
                switch (providerState) {
                  AsyncData(:final value) => switch (value) {
                      Some(:final value) => switch (value) {
                          AuthMethod.credentials => CoreInput(
                              label: Styled.text("Password"),
                              circularBorderRadius: 30,
                              placeholder: "********",
                              controller: passwordController,
                              obscureText: true,
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
                          _ => const SizedBox()
                        },
                      None() => const SizedBox(),
                    },
                  _ => const SizedBox()
                },
                switch (loginState) {
                  AsyncError(:MethodError value) =>
                    Styled.text(value.getMessage)
                        .fontSize(12)
                        .textColor(Colors.redAccent),
                  _ => const SizedBox()
                },
                CoreButton(
                  disabled: loginState.isLoading || providerState.isLoading,
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) return;
                    switch (providerState) {
                      case AsyncData():
                        {
                          switch (providerState.value) {
                            case Some(:final value):
                              switch (value) {
                                case AuthMethod.google:
                                  {
                                    showToast("Not available yet");
                                    break;
                                  }
                                default:
                                  ref
                                      .read(loginProvider.notifier)
                                      .loginWithCredentials(
                                        emailController.text,
                                        passwordController.text,
                                      );
                              }
                            case None():
                              {
                                await ref
                                    .read(findAuthMethodProvider.notifier)
                                    .findProvider(
                                      emailController.text,
                                    );
                                break;
                              }
                          }
                        }
                      default:
                        {
                          await ref
                              .read(findAuthMethodProvider.notifier)
                              .findProvider(
                                emailController.text,
                              );
                        }
                    }
                  },
                  child: switch (providerState) {
                    AsyncLoading() => [
                        Styled.text("Continue").fontWeight(FontWeight.bold),
                        const CupertinoActivityIndicator(
                          radius: 8,
                        ),
                      ].toRow(
                        mainAxisSize: MainAxisSize.min,
                        separator: const SizedBox(
                          width: 10,
                        ),
                      ),
                    AsyncData() => switch (providerState.value) {
                        Some(:final value) => switch (value) {
                            AuthMethod.credentials => switch (loginState) {
                                AsyncLoading() => [
                                    Styled.text("Log in")
                                        .fontWeight(FontWeight.bold),
                                    const CupertinoActivityIndicator(
                                      radius: 8,
                                    )
                                  ].toRow(
                                    mainAxisSize: MainAxisSize.min,
                                    separator: const SizedBox(
                                      width: 10,
                                    ),
                                  ),
                                _ => Styled.text("Log in")
                                    .fontWeight(FontWeight.bold),
                              },
                            AuthMethod.google =>
                              Styled.text("Continue with Google"),
                            _ => Styled.text("Continue")
                          },
                        None() => Styled.text("Continue"),
                      },
                    _ => Styled.text("Continue").fontWeight(FontWeight.bold),
                  },
                ),
              ].toColumn(
                separator: const SizedBox(
                  height: 10,
                ),
              ),
            ),
            [
              Styled.text("Don't have an account yet?")
                  .textColor(Colors.black54)
                  .fontSize(13),
              TextButton(
                onPressed: pushToRegister,
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
            .padding(horizontal: 20),
      ),
    );
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
