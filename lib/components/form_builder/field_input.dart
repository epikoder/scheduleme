import 'package:flutter/material.dart';

enum FieldType {
  text,
  textArea,
  dropDown,
  checkBox;

  static FieldType fromString(String str) {
    return switch (str) {
      "textArea" => FieldType.textArea,
      "dropDown" => FieldType.dropDown,
      "checkBox" => FieldType.checkBox,
      _ => FieldType.text,
    };
  }

  String get string => name;
}

class FieldInputTitle {
  FieldInputTitle({required this.text, this.isRequired = false});
  String text;
  bool isRequired;
}

abstract class FieldInput {
  FieldInput(this.fieldType);

  late final FieldType fieldType;
  late final String name;
  late final String? placeholder;
  late final FieldInputTitle title;
  late bool isEnabled;

  FieldInput.fromJson(dynamic jsonMap);
  Map<String, dynamic> toJson();
  Widget build(BuildContext context);
}
