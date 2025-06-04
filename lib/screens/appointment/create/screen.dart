import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/components/form_builder/form_builder.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/screens/spaces/manage/state.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

class CreateAppointment extends ConsumerStatefulWidget {
  const CreateAppointment({super.key});

  @override
  CreateAppointmentState createState() => CreateAppointmentState();
}

class CreateAppointmentState extends ConsumerState<CreateAppointment> {
  final formKey = GlobalKey<FormState>();
  var formJson = <Map<String, dynamic>>[];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        formJson = [...AppointmentFormState.formJson];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Create Appointment", actions: [
          IconButton(
            // TODO: admin priviledge
            onPressed: () async {
              await Compass.push("/spaces/manage");
              setState(() {
                formJson = [...AppointmentFormState.formJson];
              });
            },
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ExtColor.buttonColor),
              padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
              minimumSize: WidgetStatePropertyAll(Size(30, 30)),
            ),
            iconSize: 20,
            icon: Styled.icon(
              Icons.settings,
            ),
          )
        ]),
        body: FormBuilderProvider(
          child: Builder(
            builder: (context) => <Widget>[
              FormBuilderFromJson(
                formKey: formKey,
                json: formJson,
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
      ),
    );
  }
}
