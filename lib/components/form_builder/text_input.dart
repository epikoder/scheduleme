import 'package:flutter/material.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/form_builder.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/utils/validator.dart';
import 'package:styled_widget/styled_widget.dart';

enum FormTextInputType {
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

  final FormTextInputType inputType;
  final int? min;
  final int? max;

  factory TextFieldInputType.fromString(Map<String, dynamic> jsonMap) {
    final ipt = jsonMap["input_type"] as String?;
    return TextFieldInputType(
      switch (ipt) {
        "emailAddress" => FormTextInputType.emailAddress,
        "password" => FormTextInputType.password,
        String() => FormTextInputType.text,
        null => FormTextInputType.text,
      },
      min: jsonMap["input_type:min"] as int?,
      max: jsonMap["input_type:max"] as int?,
    );
  }

  String? Function(String?)? validator() => switch (inputType) {
        FormTextInputType.emailAddress => (text) {
            return text == null || text.isEmpty
                ? "field is required"
                : !isEmailValid(text)
                    ? "email is invalid"
                    : null;
          },
        FormTextInputType() => null,
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
      ..isEnabled = jsonMap["is_enabled"] ?? true
      ..fieldInputType = TextFieldInputType.fromString(jsonMap)
      ..controller = TextEditingController(text: jsonMap["default_value"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "field_type": fieldType.string,
    };
  }

  @override
  Widget build(BuildContext context) {
    final provider = FormBuilderProvider.of(context)!;
    provider.controllers[name] = controller;
    return CoreInput(
      isDense: true,
      textArea: fieldType == FieldType.textArea,
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
      obscureText: fieldInputType.inputType == FormTextInputType.password,
    );
  }
}
