import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core/core_widget.dart';
import 'package:scheduleme/theme.dart';
import 'package:styled_widget/styled_widget.dart';

class CoreInput extends CoreStatelessWidget {
  const CoreInput({
    super.key,
    required this.label,
    this.placeholder,
  });

  final Widget label;
  final String? placeholder;

  @override
  Widget createAndroidWidget(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white54),
              borderRadius: BorderRadius.circular(10)),
          label: label,
        ),
      );

  @override
  Widget createIosWidget(BuildContext context) => [
        label,
        CupertinoTextField(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          placeholder: placeholder,
        )
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
}
