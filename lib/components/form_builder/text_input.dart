import 'package:flutter/material.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/form_builder.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:styled_widget/styled_widget.dart';

enum MyTextInputType {
  emailAddress,
  password,
  text,
}

class TextFieldInputType {
  TextFieldInputType(
    this.inputType, {
    this.min,
    this.max,
  });
  final MyTextInputType inputType;
  final int? min;
  final int? max;

  factory TextFieldInputType.fromString(Map<String, dynamic> jsonMap) {
    final ipt = jsonMap["input_type"] as String?;
    return TextFieldInputType(
      switch (ipt) {
        "emailAddress" => MyTextInputType.emailAddress,
        "password" => MyTextInputType.password,
        String() => MyTextInputType.text,
        null => MyTextInputType.text,
      },
      min: jsonMap["input_type:min"] as int?,
      max: jsonMap["input_type:max"] as int?,
    );
  }

  String? Function(String?)? validator() => switch (inputType) {
        MyTextInputType.emailAddress => (text) {
            return text == null || text.isEmpty ? "email is invalud" : null;
          },
        MyTextInputType() => null,
      };
}

class TextInput extends FieldInput {
  TextInput() : super(FieldType.text);
  late final TextFieldInputType fieldInputType;
  late final TextEditingController controller;

  @override
  factory TextInput.fromJson(dynamic jsonMap) {
    final bool isRequired = jsonMap["title"]["is_required"] ?? false;
    return TextInput()
      ..name = jsonMap["name"]
      ..placeholder = jsonMap["placeholder"]
      ..title = FieldInputTitle(
        text: jsonMap["title"]["text"],
        isRequired: isRequired,
      )
      ..fieldInputType = TextFieldInputType.fromString(jsonMap)
      ..controller = TextEditingController(text: jsonMap["default_value"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "formType": formType.asString,
    };
  }

  @override
  Widget build(BuildContext context) {
    final provider = FormBuilderProvider.of(context)!;
    provider.controllers[name] = controller;
    return CoreInput(
      isDense: true,
      controller: controller,
      placeholder: placeholder,
      label: title.isRequired
          ? Text.rich(
              TextSpan(text: title.text, children: const [
                TextSpan(text: "*", style: TextStyle(color: Colors.red))
              ]),
            )
          : Styled.text(title.text),
      validator: fieldInputType.validator(),
      obscureText: fieldInputType.inputType == MyTextInputType.password,
    );
  }
}
