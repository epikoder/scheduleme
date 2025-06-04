import 'package:flutter/material.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

PreferredSizeWidget appBar(String title, {List<Widget>? actions}) {
  return AppBar(
    leading: IconButton(
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
    ),
    centerTitle: true,
    title: Styled.text(title).fontSize(16),
    actions: [
      ...actions ?? [],
      const SizedBox(
        width: 10,
      )
    ],
  );
}
