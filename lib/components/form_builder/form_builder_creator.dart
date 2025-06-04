import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:option_result/result.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/text_input.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/dropdown.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/utils/slugify.dart';
import 'package:scheduleme/utils/toast.dart';
import 'package:styled_widget/styled_widget.dart';

class FormCreatorController extends ValueNotifier<List<CreatorFieldInput>> {
  FormCreatorController(super.value);

  void addByName(CreatorFieldInput value) {
    final index = this
        .value
        .indexWhere((fieldInput) => fieldInput.name.value == value.name.value);

    var tmp = this.value;
    tmp[index] = value;
    tmp = [...tmp];
    this.value = tmp;
  }

  Result<(), String> add(CreatorFieldInput value) {
    if (this.value.firstWhereOrNull(
            (fieldInput) => fieldInput.name.value == value.name.value) !=
        null) {
      return Err("Field with name :${value.name.string} exist");
    }

    var tmp = this.value;
    tmp.add(value);
    tmp = [...tmp];
    this.value = tmp;
    return const Ok(());
  }

  void addAll(List<CreatorFieldInput> value) {
    final names = this.value.map((fieldInput) => fieldInput.name.value);
    final filteredValue =
        value.where((fieldInput) => !names.contains(fieldInput.name.value));
    var tmp = this.value;
    tmp.addAll(filteredValue);
    tmp = [...tmp];
    this.value = tmp;
  }

  CreatorFieldInput removeAt(int index) {
    var tmp = value;
    final removedItem = tmp.removeAt(index);
    tmp = [...tmp];
    value = tmp;
    return removedItem;
  }

  void insert(int index, CreatorFieldInput value) {
    var tmp = this.value;
    tmp.insert(index, value);
    tmp = [...tmp];
    this.value = tmp;
  }

  void forceUpdate() {
    var tmp = value;
    tmp = [...tmp];
    value = tmp;
  }
}

class FormCreatorProvider extends InheritedWidget {
  const FormCreatorProvider({
    super.key,
    required super.child,
    required this.controller,
  });

  final FormCreatorController controller;

  static FormCreatorProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FormCreatorProvider>();
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return child != oldWidget.child;
  }
}

class CreatorFieldInput {
  CreatorFieldInput(this.fieldType);

  final FieldType fieldType;

  final name = "".obs;
  final Rx<String?> placeholder = Rx(null);
  final title = Rx(FieldInputTitle(text: ""));
  final isEnabled = true.obs;

  // text
  final inputType = FormTextInputType.text.obs;

  // dropdown
  final dropDownMenu = <String>[].obs;

  factory CreatorFieldInput.fromJson(dynamic jsonMap) =>
      CreatorFieldInput(FieldType.text);

  Map<String, dynamic> toJson() => {
        "name": name.value,
        "placeholder": placeholder.value,
        "title": {
          "text": title.value.text,
          "is_required": title.value.isRequired,
        },
        "is_enabled": isEnabled.value,
        "field_type": fieldType.string,
        ...(switch (fieldType) {
          FieldType.text => {"input_type": inputType.value.name},
          FieldType.dropDown => {
              "dropdown_items": [...dropDownMenu],
            },
          _ => {}
        })
      };
}

class FormCreatorField extends StatefulWidget {
  const FormCreatorField({
    super.key,
    required this.fieldInput,
    required this.controller,
  });
  final CreatorFieldInput fieldInput;
  final FormCreatorController controller;

  @override
  FormCreatorFieldState createState() => FormCreatorFieldState();
}

class FormCreatorFieldState extends State<FormCreatorField> {
  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    return <Widget>[
      Styled.icon(Icons.apps_sharp).iconSize(18),
      [
        Styled.text(widget.fieldInput.title.value.text.capitalize!),
        Text.rich(TextSpan(
            text: widget.fieldInput.fieldType.name,
            style: TextStyle(color: Colors.grey.shade700, fontSize: 10),
            children: [
              const TextSpan(text: " :: "),
              TextSpan(text: widget.fieldInput.name.value),
            ])),
      ]
          .toColumn(crossAxisAlignment: CrossAxisAlignment.start)
          .expanded(flex: 1),
      Styled.icon(Icons.edit)
          .iconSize(18)
          .paddingAll(5)
          .ripple(splashColor: ExtColor.buttonColor)
          .gestures(
              onTap: () => FormCreatorFieldManager.showFieldManager(
                    context,
                    controller,
                    widget.fieldInput.fieldType,
                    fieldInput: widget.fieldInput,
                  ))
          .clipOval(),
      Styled.icon(Icons.delete)
          .iconSize(18)
          .iconColor(Colors.red)
          .paddingAll(5)
          .ripple(splashColor: ExtColor.buttonColor)
          .gestures(
              onTap: () => FormCreatorFieldManager.showFieldDeleteDialog(
                    context,
                    controller,
                    widget.fieldInput,
                  ))
          .clipOval(),
    ]
        .toRow(
          separator: const SizedBox(
            width: 10,
          ),
          crossAxisAlignment: CrossAxisAlignment.start,
        )
        .padding(all: 10)
        .card(
            color: widget.fieldInput.isEnabled.value
                ? Colors.white
                : Colors.grey.shade300)
        .marginSymmetric(vertical: 2);
  }
}

class FormCreatorFieldManager extends StatefulWidget {
  const FormCreatorFieldManager({
    super.key,
    required this.fieldType,
    required this.controller,
    this.fieldInput,
  });
  final FieldType fieldType;
  final FormCreatorController controller;
  final CreatorFieldInput? fieldInput;

  @override
  FormCreatorFieldManagerState createState() => FormCreatorFieldManagerState();

  static void showFieldManager(BuildContext context,
      FormCreatorController controller, FieldType fieldType,
      {CreatorFieldInput? fieldInput}) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => [
        FormCreatorFieldManager(
          fieldType: fieldType,
          controller: controller,
          fieldInput: fieldInput,
        )
            .constrained(minHeight: 100, minWidth: 250, maxWidth: 400)
            .padding(all: 10)
            .card(color: Colors.white)
      ]
          .toColumn(mainAxisAlignment: MainAxisAlignment.center)
          .paddingSymmetric(horizontal: 10),
    );
  }

  static void showFieldDeleteDialog(BuildContext context,
      FormCreatorController controller, CreatorFieldInput fieldInput) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => CupertinoAlertDialog(
        title: Styled.text("Delete"),
        content: Text.rich(
          TextSpan(
            text: "You are about to delete ",
            children: [
              TextSpan(
                text: fieldInput.title.value.text,
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
              const TextSpan(
                text: " this action is irreversible",
              ),
              const TextSpan(
                text: "\n\nDo you want to proceed?",
              ),
            ],
          ),
        ),
        actions: [
          CupertinoButton(
            onPressed: Navigator.of(ctx).pop,
            child: Styled.text("Cancel").fontSize(14).textColor(Colors.red),
          ),
          CupertinoButton(
            onPressed: () {
              controller.value
                  .removeWhere((fi) => fi.name.value == fieldInput.name.value);
              controller.forceUpdate();
              Navigator.of(ctx).pop();
            },
            child: Styled.text("Continue").fontSize(14).textColor(Colors.green),
          ),
        ],
      ).paddingSymmetric(horizontal: 10),
    );
  }
}

class FormCreatorFieldManagerState extends State<FormCreatorFieldManager> {
  late final CreatorFieldInput state;
  final formKey = GlobalKey<FormState>();
  FormTextInputType inputType = FormTextInputType.text;
  final nameController = TextEditingController();

  @override
  void initState() {
    state = widget.fieldInput ?? CreatorFieldInput(widget.fieldType);
    nameController.text = widget.fieldInput?.name.value ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: <Widget>[
        switch (widget.fieldType) {
          FieldType.text => Styled.text("Text Field"),
          FieldType.textArea => Styled.text("Text Area"),
          FieldType.dropDown => Styled.text("Dropdown"),
          FieldType.checkBox => Styled.text("Checkbox"),
        },
        const SizedBox(
          height: 10,
        ),
        CoreInput(
            isDense: true,
            controller: TextEditingController(text: state.title.value.text),
            label: Styled.text("Title"),
            onChanged: (value) {
              state.title.value.text = value;
              state.name.value = slugify(value, delimiter: "_");
              nameController.text = state.name.value;
            },
            validator: (str) =>
                str == null || str.isEmpty ? "Title is required" : null),
        CoreInput(
            enabled: false,
            isDense: true,
            controller: nameController,
            label: Styled.text("Unique name"),
            validator: (str) =>
                str == null || str.isEmpty ? "Please enter a title" : null),
        CoreInput(
          isDense: true,
          controller: TextEditingController(text: state.placeholder.value),
          label: Styled.text("Hint message"),
          onChanged: (value) {
            state.placeholder.value = value;
          },
        ),
        if (state.fieldType == FieldType.dropDown)
          CoreInput(
            isDense: true,
            textArea: true,
            controller: TextEditingController(
                text: state.dropDownMenu.fold("",
                    (v, i) => "${v != null && v.isNotEmpty ? "$v, " : ""}$i")),
            label: Styled.text("Items"),
            placeholder: "e.g item1, item2, item3",
            onChanged: (value) {
              state.dropDownMenu.value = value
                  .split(",")
                  .map((v) => v.trim())
                  .where((v) => v.isNotEmpty)
                  .toList();
            },
          ),
        if (state.fieldType == FieldType.text)
          Obx(
            () => CoreDropDown(
              onSelected: (value) {
                state.inputType.value = value ?? FormTextInputType.text;
              },
              value: state.inputType.value.name,
              items: FormTextInputType.values,
              placeholder: state.placeholder.value,
              builder: (ctx, item) => Styled.text(item.name).fontSize(12),
            ),
          ),
        [
          Obx(
            () => Transform.scale(
              scale: .8,
              child: Checkbox(
                value: state.title.value.isRequired,
                onChanged: (checked) => state.title.value = FieldInputTitle(
                    text: state.title.value.text, isRequired: checked ?? false),
              ),
            ),
          ),
          Styled.text("Required").fontSize(14)
        ].toRow(),
        [
          Obx(
            () => Transform.scale(
              scale: .8,
              child: Checkbox(
                value: state.isEnabled.value,
                onChanged: (checked) => state.isEnabled.value = checked ?? true,
              ),
            ),
          ),
          Styled.text("Visible").fontSize(14)
        ].toRow(),
        CoreButton(
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            if (widget.fieldInput != null) {
              widget.controller.addByName(state);
            } else {
              final result = widget.controller.add(state);
              if (result.isErr()) {
                showToast(result.unwrapErr());
                return;
              }
            }
            Navigator.of(context).pop();
          },
          child: Styled.text("Save").paddingSymmetric(horizontal: 30),
        ),
      ].toColumn(
        separator: const SizedBox(
          height: 10,
        ),
      ),
    );
  }
}
