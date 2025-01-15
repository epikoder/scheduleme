import 'package:flutter/material.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/text_input.dart';
import 'package:styled_widget/styled_widget.dart';

List<FieldInput> formFromJson(List<Map<String, dynamic>> jsonMap) {
  return jsonMap
      .map((entry) =>
          switch (FieldType.fromString(entry["field_type"] as String)) {
            FieldType.text => TextInput.fromJson(entry),
          })
      .toList();
}

class FormBuilderProvider extends InheritedWidget {
  FormBuilderProvider({
    super.key,
    required super.child,
  });
  final controllers = <String, TextEditingController>{};

  static FormBuilderProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormBuilderProvider>();
  }

  Map<String, String> values() {
    return controllers.entries.map((en) => ({en.key: en.value.text})).fold({},
        (acc, map) {
      acc.addAll(map);
      return acc;
    });
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return child != oldWidget.child;
  }
}

class FormBuilderFromJson extends StatelessWidget {
  const FormBuilderFromJson({
    super.key,
    required this.json,
    this.formKey,
    this.spacing,
  });
  final GlobalKey<State<StatefulWidget>>? formKey;
  final List<Map<String, dynamic>> json;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      form: formFromJson(json),
      formKey: formKey,
      spacing: spacing,
    );
  }
}

class FormBuilder extends StatelessWidget {
  const FormBuilder({
    super.key,
    required this.form,
    this.formKey,
    this.spacing = 10,
  });
  final GlobalKey<State<StatefulWidget>>? formKey;
  final List<FieldInput> form;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    assert(FormBuilderProvider.of(context) != null,
        "FormBuilderProvider ancestor widget required");
    return Form(
      key: formKey,
      child: form
          .map(
            (field) => field.build(context),
          )
          .toList()
          .toColumn(
            separator: SizedBox(
              height: spacing ?? 10,
            ),
          ),
    );
  }
}
