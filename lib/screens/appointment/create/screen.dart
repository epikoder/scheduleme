import 'package:flutter/material.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/components/form_builder/form_builder.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

class CreateAppointment extends StatelessWidget {
  CreateAppointment({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[
        FormBuilderProvider(
          child: Builder(
            builder: (context) => <Widget>[
              Styled.text("Create Appointment").padding(vertical: 10),
              FormBuilderFromJson(
                formKey: formKey,
                json: const [
                  {
                    "name": "full_name",
                    "field_type": "text",
                    "placeholder": "John Doe",
                    "title": {"text": "Full Name", "is_required": true},
                  },
                  {
                    "name": "email",
                    "field_type": "text",
                    "placeholder": "johndoe@domain.com",
                    "title": {"text": "Email", "is_required": true},
                    "input_type": "emailAddress",
                  },
                  {
                    "name": "phone",
                    "field_type": "text",
                    "placeholder": "(234) 905 2257 844",
                    "title": {
                      "text": "Phone",
                    },
                    "input_type": "phone",
                  },
                ],
              ),
              CoreButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) {
                    return;
                  }
                  final m = FormBuilderProvider.of(context)!.values();
                  print(m);
                },
                child: Styled.text("Create"),
              )
            ]
                .toColumn(
                    separator: const SizedBox(
                  height: 20,
                ))
                .padding(all: 10)
                .scrollable(),
          ),
        ),
        const FloatingBackButton(),
        IconButton(
          // TODO: admin priviledge
          onPressed: () => Compass.push("/spaces/manage/customize_appointment"),
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(ExtColor.buttonColor),
            padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
            minimumSize: WidgetStatePropertyAll(Size(30, 30)),
          ),
          iconSize: 20,
          icon: Styled.icon(
            Icons.settings,
          ),
        ).positioned(
          top: 15,
          right: 10,
        ),
      ].toStack(),
    );
  }
}
