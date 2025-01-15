import 'package:flutter/material.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:scheduleme/services/navigation.service.dart';

class FloatingBackButton extends StatelessWidget {
  const FloatingBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: Compass.pop,
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(ExtColor.buttonColor),
        padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
        minimumSize: WidgetStatePropertyAll(Size(30, 30)),
      ),
      iconSize: 20,
      icon: Styled.icon(
        Icons.arrow_back,
      ),
    ).positioned(
      top: 15,
      left: 10,
    );
  }
}
