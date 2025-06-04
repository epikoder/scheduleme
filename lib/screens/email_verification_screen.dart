// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:option_result/option.dart';
import 'package:pinput/pinput.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/services/account/email_verification.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/core/types.dart';
import 'package:scheduleme/utils/toast.dart';
import 'package:styled_widget/styled_widget.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({
    super.key,
    required this.email,
  });

  final String email;
  @override
  EmailVerificationScreenState createState() => EmailVerificationScreenState();
}

class EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  final length = 5;
  final borderColor = const Color.fromRGBO(114, 178, 238, 1);
  final errorColor = const Color.fromRGBO(255, 234, 238, 1);
  final fillColor = const Color.fromRGBO(222, 231, 240, .57);
  final controller = TextEditingController();
  final focusNode = FocusNode();

  bool disabled = true;

  void listener() {
    setState(() {
      disabled = controller.length != length;
    });
  }

  @override
  void initState() {
    controller.addListener(listener);
    super.initState();
  }

  @override
  void dispose() {
    controller.removeListener(listener);
    controller.dispose();
    super.dispose();
  }

  Future<void> onContinue() async {
    if (controller.text.length != length) return;
    await ref
        .read(verifyEmailProvider.notifier)
        .verifyEmail(widget.email, controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final sendingVerificationState = ref.watch(sendVerificationTokenProvider);
    final verifyEmailState = ref.watch(verifyEmailProvider);

    ref.listen(verifyEmailProvider, (_, state) {
      switch (state) {
        case AsyncData(:final value):
          {
            switch (value) {
              case Some(:final value):
                {
                  switch (value.code) {
                    case null:
                      Compass.pushReplacement("/dashboard");
                    case 2002:
                      Compass.pushReplacement("/account-setup");
                  }
                }
              case None():
            }
          }
        case AsyncError(:MethodError error):
          showToast(error.getMessage, context: context);
      }
    });

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Color.fromRGBO(30, 60, 87, 1),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.transparent),
      ),
    );
    return CoreScaffold(
      body: CoreScreen(
        child: <Widget>[
          [Styled.text("Verification").fontSize(18).fontWeight(FontWeight.bold)]
              .toRow(mainAxisAlignment: MainAxisAlignment.center),
          [
            Styled.text("Verification code will be sent to the email below")
                .textColor(Colors.grey),
            Styled.text(widget.email).textColor(Colors.black87),
          ].toColumn(
            separator: const SizedBox(
              height: 10,
            ),
          ),
          [
            Pinput(
              length: length,
              defaultPinTheme: defaultPinTheme,
              focusNode: focusNode,
              controller: controller,
              enabled: !verifyEmailState.isLoading,
            ),
            _ResendButton(
              email: widget.email,
            ),
          ].toColumn(
            separator: const SizedBox(
              height: 10,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          switch (verifyEmailState) {
            AsyncLoading() => [
                CoreButton(
                  disabled: disabled || sendingVerificationState.isLoading,
                  onPressed: () {},
                  child: [
                    Styled.text("Continue"),
                    const CupertinoActivityIndicator()
                  ].toRow(
                    separator: const SizedBox(width: 10),
                  ),
                ),
              ].toRow(
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            _ => CoreButton(
                disabled: disabled || sendingVerificationState.isLoading,
                onPressed: onContinue,
                child: Styled.text("Continue"),
              ),
          }
        ]
            .toColumn(
                separator: const SizedBox(
                  height: 20,
                ),
                crossAxisAlignment: CrossAxisAlignment.center)
            .padding(vertical: 40),
      ),
    );
  }
}

const verificationTokenTimeout = 30;

class _ResendButton extends ConsumerStatefulWidget {
  const _ResendButton({required this.email});
  final String email;
  @override
  _ResendButtonState createState() => _ResendButtonState();
}

class _ResendButtonState extends ConsumerState<_ResendButton> {
  final onTap = TapGestureRecognizer();
  bool tokenRequested = false;
  Duration countDown = const Duration();

  @override
  initState() {
    onTap.onTap = () async {
      setState(() {
        tokenRequested = true;
      });
      await ref
          .read(sendVerificationTokenProvider.notifier)
          .sendVerificationToken(widget.email);
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final resendEmailState = ref.watch(sendVerificationTokenProvider);
    ref.listen(sendVerificationTokenProvider, (_, value) {
      switch (value) {
        case AsyncLoading():
          {}
        case AsyncData(:final value):
          {
            switch (value) {
              case Some(:final value):
                {
                  if (value == SendVerificationMailResponse.tooManyRequest) {
                    showToast("Too many request", context: context);
                    return;
                  }
                  if (value == SendVerificationMailResponse.failed) {
                    showToast("Email missing", context: context);
                    return;
                  }

                  setState(() => tokenRequested = true);
                  countDown = const Duration(seconds: verificationTokenTimeout);
                  setState(() => {});
                  Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (countDown.inSeconds > 0) {
                      countDown -= const Duration(seconds: 1);
                      if (mounted) {
                        setState(() {});
                      }
                    } else {
                      timer.cancel();
                    }
                  });
                }
              case None():
            }
          }
        case AsyncError(:MethodError error):
          showToast(error.getMessage, context: context);
      }
    });

    return tokenRequested
        ? Text.rich(TextSpan(
            text: "Resend in.. ",
            style: const TextStyle(fontSize: 12),
            children: [
              countDown.inSeconds > 0
                  ? TextSpan(
                      style: const TextStyle(color: Colors.grey),
                      text:
                          "${countDown.inSeconds > 60 ? "${(countDown.inSeconds / 60).floor()}." : countDown.inSeconds % 60}s")
                  : switch (resendEmailState) {
                      AsyncLoading() => const TextSpan(
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                          text: "Please wait..."),
                      _ => TextSpan(
                          style: const TextStyle(
                            color: ExtColor.textButtonColor,
                          ),
                          recognizer: onTap,
                          text: "Resend now"),
                    }
            ],
          ))
        : TextButton(
            onPressed: onTap.onTap,
            child: Styled.text("Send Verification Token").fontSize(12),
          );
  }
}
