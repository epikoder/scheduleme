import 'package:flutter/material.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

void showToast(String message, {BuildContext? context}) {
  ScaffoldMessenger.of(context ?? NavigationService.context)
      .showSnackBar(SnackBar(content: Styled.text(message).fontSize(12)));
}
