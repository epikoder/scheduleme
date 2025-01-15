import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:styled_widget/styled_widget.dart';

class CoreInput extends CoreStatelessWidget {
  const CoreInput({
    super.key,
    this.label,
    this.placeholder,
    this.obscureText = false,
    this.validator,
    this.isDense = true,
    this.controller,
  });

  final Widget? label;
  final String? placeholder;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool? isDense;
  final TextEditingController? controller;

  @override
  Widget createAndroidWidget(BuildContext context) => TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.circular(30),
          ),
          label: label,
          labelStyle: const TextStyle(fontSize: 12),
          hintStyle: const TextStyle(fontSize: 12),
          helperStyle: const TextStyle(fontSize: 12),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(30),
          ),
          hintText: placeholder,
          isDense: isDense,
          contentPadding:
              (isDense != null && isDense!) ? const EdgeInsets.all(15) : null,
        ),
        obscureText: obscureText,
        validator: validator,
        cursorHeight: 12,
        style: const TextStyle(fontSize: 12),
      );

  @override
  Widget createIosWidget(BuildContext context) => [
        if (label != null) label!,
        CupertinoTextField(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(10),
          ),
          placeholder: placeholder,
        )
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start);
}
