import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/components/form_builder/field_input.dart';
import 'package:scheduleme/components/form_builder/form_builder_creator.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/screens/users/invite/partials/customize_form.dart';
import 'package:styled_widget/styled_widget.dart';

class UserInviteFormEditScreen extends StatefulWidget {
  const UserInviteFormEditScreen({super.key});

  @override
  UserInviteFormEditScreenState createState() =>
      UserInviteFormEditScreenState();
}

class UserInviteFormEditScreenState extends State<UserInviteFormEditScreen> {
  final controller = FormCreatorController([]);

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      // controller.value = [...AppointmentFormState.fields];
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Customize Application", actions: [
          IconButton(
            // TODO: admin priviledge
            onPressed: () {
              // AppointmentFormState.fields.value = controller.value;
              // final formData =
              //     controller.value.map((fields) => fields.toJson()).toList();
              // AppointmentFormState.formJson.value = formData;
              // showToast("Saved successfully");
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ExtColor.buttonColor),
              padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
              minimumSize: WidgetStatePropertyAll(Size(30, 30)),
            ),
            iconSize: 20,
            icon: Styled.icon(
              Icons.save,
            ),
          )
        ]),
        body: FormCreatorProvider(
            controller: controller,
            child: const CustomizeMemberInviteFormPartial()),
        floatingActionButton: _FloatingActionButton(controller: controller),
      ),
    );
  }
}

class _FloatingActionButton extends StatefulWidget {
  const _FloatingActionButton({required this.controller});

  final FormCreatorController controller;
  @override
  _FloatingActionButtonState createState() => _FloatingActionButtonState();
}

class _FloatingActionButtonState extends State<_FloatingActionButton> {
  bool isOpen = false;

  void onInputTypeSelection(BuildContext context,
      FormCreatorController controller, FieldType fieldType) {
    Navigator.of(context).pop();
    FormCreatorFieldManager.showFieldManager(context, controller, fieldType);
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;

    return FloatingActionButton(
      onPressed: () {
        setState(() {
          isOpen = true;
        });
        showCupertinoModalPopup(
          barrierDismissible: true,
          barrierColor: Colors.black12,
          context: context,
          builder: (ctx) => CoreScreen(
            child: [
              _buttons("Text Field", Icons.text_fields,
                  onPressed: () =>
                      onInputTypeSelection(ctx, controller, FieldType.text)),
              _buttons("Text Area", Icons.text_fields,
                  onPressed: () => onInputTypeSelection(
                      ctx, controller, FieldType.textArea)),
              _buttons("Dropdown", Icons.menu,
                  onPressed: () => onInputTypeSelection(
                      ctx, controller, FieldType.dropDown)),
              _buttons("Checkbox", Icons.check_box,
                  onPressed: () => onInputTypeSelection(
                      ctx, controller, FieldType.checkBox)),
            ]
                .toColumn(
                    separator: const SizedBox(
                  height: 5,
                ))
                .clipRRect(all: 10)
                .padding(all: 10)
                .backgroundColor(Colors.white)
                .clipRRect(all: 10)
                .card(elevation: 10)
                .width(320)
                .height(400), // modal height
          ).alignment(
            const Alignment(0.0, 0.7), // align modal
          ),
        ).then((_) => setState(() {
              isOpen = false;
            }));
      },
      shape: const CircleBorder(),
      child: Styled.icon(Icons.add)
          .padding(all: 10)
          .clipRRect(all: 50)
          .rotate(angle: isOpen ? 1 : 0, animate: true)
          .animate(const Duration(milliseconds: 300), Curves.easeInCubic),
    );
  }

  Widget _buttons(
    String text,
    IconData icon, {
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return LayoutBuilder(
      builder: (ctx, constraint) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(
            Size(constraint.maxWidth, 50),
          ),
          backgroundColor: const WidgetStatePropertyAll(
            Color.fromARGB(255, 242, 242, 242),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        ),
        child: [
          Styled.icon(icon, color: iconColor)
              .padding(all: 3)
              .backgroundColor(Colors.white)
              .clipRRect(all: 10),
          Styled.text(text).textColor(Colors.black).fontSize(11),
        ].toRow(
          separator: const SizedBox(
            width: 20,
          ),
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}
