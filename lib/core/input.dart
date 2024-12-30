import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core/core_widget.dart';
import 'package:styled_widget/styled_widget.dart';

class CoreInput extends CoreStatelessWidget {
  const CoreInput({
    super.key,
    required this.label,
    this.placeholder,
    this.obscure,
  });

  final Widget label;
  final String? placeholder;
  final bool? obscure;

  @override
  Widget createAndroidWidget(BuildContext context) => TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.circular(30),
          ),
          label: label,
          // isDense: true,
        ),
        style: const TextStyle(fontSize: 14),
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
