import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/form_builder.dart';
import 'package:scheduleme/core_widgets/dropdown.dart';
import 'package:styled_widget/styled_widget.dart';

class DropdownInput extends FieldInput {
  DropdownInput() : super(FieldType.dropDown);
  late final TextEditingController controller;
  List<dynamic> items = [];
  final selected = "".obs;

  @override
  Widget build(BuildContext context) {
    final provider = FormBuilderProvider.of(context)!;
    provider.controllers[name] = controller;

    return Obx(
      () => CoreDropDown(
        value: selected.value,
        builder: (ctx, value) => Styled.text(value.toString()),
        items: items,
        placeholder: placeholder,
        emptyField: !title.isRequired,
        onSelected: (value) {
          final v = value ?? "";
          controller.text = v;
          selected.value = v;
        },
      ),
    );
  }

  @override
  factory DropdownInput.fromJson(dynamic jsonMap) {
    final bool isRequired = jsonMap["title"]["is_required"] ?? false;
    return DropdownInput()
      ..name = jsonMap["name"]
      ..placeholder = jsonMap["placeholder"]
      ..title = FieldInputTitle(
        text: jsonMap["title"]["text"],
        isRequired: isRequired,
      )
      ..items = (jsonMap["dropdown_items"] ?? []) as List<dynamic>
      ..isEnabled = jsonMap["is_enabled"] ?? true
      ..controller = TextEditingController(text: jsonMap["default_value"]);
  }

  @override
  Map<String, dynamic> toJson() => {};
}
