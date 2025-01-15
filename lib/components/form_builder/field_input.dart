import 'package:flutter/material.dart';

enum FieldType {
  text;

  static FieldType fromString(String str) {
    return switch (str) {
      "text" => FieldType.text,
      String() => throw UnimplementedError(),
    };
  }

  String get asString => switch (this) {
        FieldType.text => "text",
      };
}

class FieldInputTitle {
  FieldInputTitle({required this.text, this.isRequired = false});
  String text;
  bool isRequired;
}

abstract class FieldInput {
  FieldInput(
    this.formType,
  );
  late final FieldType formType;
  late final String name;
  late final String? placeholder;
  late final FieldInputTitle title;

  FieldInput.fromJson(dynamic jsonMap);
  Map<String, dynamic> toJson();
  Widget build(BuildContext context);
}
