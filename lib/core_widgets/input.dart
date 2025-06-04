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
    this.onChanged,
    this.focusNode,
    this.enabled,
    this.circularBorderRadius = 5,
    this.textArea = false,
  });

  final Widget? label;
  final String? placeholder;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool? isDense;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final bool? enabled;
  final double circularBorderRadius;
  final bool textArea;

  @override
  Widget createAndroidWidget(BuildContext context) => obscureText
      ? _AndroidPasswordInput(
          controller: controller,
          isDense: isDense,
          label: label,
          obscureText: true,
          placeholder: placeholder,
          validator: validator,
          onChanged: onChanged,
          circularBorderRadius: circularBorderRadius,
        )
      : TextFormField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white54),
              borderRadius: BorderRadius.circular(circularBorderRadius),
            ),
            label: label,
            labelStyle: const TextStyle(fontSize: 12),
            hintStyle: const TextStyle(
                fontSize: 12, color: Color.fromARGB(255, 147, 147, 147)),
            helperStyle: const TextStyle(fontSize: 12),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(circularBorderRadius),
            ),
            hintText: placeholder,
            isDense: isDense,
            contentPadding:
                (isDense != null && isDense!) ? const EdgeInsets.all(15) : null,
          ),
          enabled: enabled,
          obscureText: obscureText,
          validator: validator,
          cursorHeight: 12,
          style: const TextStyle(fontSize: 12),
          onChanged: onChanged,
          focusNode: focusNode,
          maxLines: textArea ? 4 : 1,
        );

  @override
  Widget createIosWidget(BuildContext context) => createAndroidWidget(context);
}

class _AndroidPasswordInput extends StatefulWidget {
  const _AndroidPasswordInput({
    this.label,
    this.placeholder,
    this.obscureText = false,
    this.validator,
    this.isDense = true,
    this.controller,
    this.onChanged,
    required this.circularBorderRadius,
  });

  final Widget? label;
  final String? placeholder;
  final bool obscureText;
  final String? Function(String?)? validator;
  final bool? isDense;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final double circularBorderRadius;

  @override
  _AndroidPasswordInputState createState() => _AndroidPasswordInputState();
}

class _AndroidPasswordInputState extends State<_AndroidPasswordInput> {
  bool hidden = true;

  @override
  Widget build(BuildContext context) {
    return [
      TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.white54),
            borderRadius: BorderRadius.circular(widget.circularBorderRadius),
          ),
          label: widget.label,
          labelStyle: const TextStyle(fontSize: 12),
          hintStyle: const TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 147, 147, 147),
          ),
          helperStyle: const TextStyle(fontSize: 12),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(widget.circularBorderRadius),
          ),
          hintText: widget.placeholder,
          isDense: widget.isDense,
          contentPadding: (widget.isDense != null && widget.isDense!)
              ? const EdgeInsets.only(top: 15, bottom: 15, left: 15, right: 40)
              : null,
        ),
        obscureText: hidden,
        validator: widget.validator,
        cursorHeight: 12,
        style: const TextStyle(fontSize: 12),
        onChanged: widget.onChanged,
      ),
      Styled.icon(hidden ? Icons.visibility_off : Icons.visibility)
          .iconSize(18)
          .gestures(
              onTap: () => setState(() {
                    hidden = !hidden;
                  }))
          .positioned(right: 10, top: 10),
    ].toStack();
  }
}
