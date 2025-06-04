import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/form_builder.dart';
import 'package:scheduleme/core_widgets/core_checkbox.dart';

class CheckboxInput extends FieldInput {
  CheckboxInput() : super(FieldType.dropDown);
  late final TextEditingController controller;
  final checked = false.obs;

  @override
  Widget build(BuildContext context) {
    final provider = FormBuilderProvider.of(context)!;
    provider.controllers[name] = controller;

    return Obx(
      () => CoreCheckbox(
        checked: checked.value,
        title: title.text,
        hint: placeholder,
        onChanged: (value) {
          final v = value ?? false;
          checked.value = v;
          controller.text = v.toString();
        },
      ),
    );
  }

  @override
  factory CheckboxInput.fromJson(dynamic jsonMap) {
    final bool isRequired = jsonMap["title"]["is_required"] ?? false;
    return CheckboxInput()
      ..name = jsonMap["name"]
      ..placeholder = jsonMap["placeholder"]
      ..title = FieldInputTitle(
        text: jsonMap["title"]["text"],
        isRequired: isRequired,
      )
      ..isEnabled = jsonMap["is_enabled"] ?? true
      ..controller = TextEditingController(text: jsonMap["default_value"]);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
