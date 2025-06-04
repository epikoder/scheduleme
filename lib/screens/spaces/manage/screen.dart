import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/components/form_info.dart';
import 'package:scheduleme/core_widgets/button.dart';
import 'package:scheduleme/core_widgets/dropdown.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/screens/spaces/manage/state.dart';
import 'package:scheduleme/services/space/appointment/form.dart';
import 'package:styled_widget/styled_widget.dart';

class ManageAppointmentForms extends ConsumerStatefulWidget {
  const ManageAppointmentForms({super.key});

  @override
  ManageAppointmentFormsState createState() => ManageAppointmentFormsState();
}

class ManageAppointmentFormsState
    extends ConsumerState<ManageAppointmentForms> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(getAppointmentFormProvider.notifier)
          .getAppointmentForms("spaceId");
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(getAppointmentFormProvider, (_, value) {
      switch (value) {
        case AsyncData(:final value):
          {
            if (value.isSome()) {
              AppointmentFormState.appointmentForms.value =
                  value.unwrap().appointmentForms;
            }
          }
      }
    });
    final state = ref.watch(getAppointmentFormProvider);

    return CoreScreen(
        child: Scaffold(
      appBar: appBar("Appointment Forms"),
      body: RefreshIndicator(
        onRefresh: () => ref
            .read(getAppointmentFormProvider.notifier)
            .getAppointmentForms("spaceId"),
        child: switch (state) {
          AsyncLoading() => [
              const CupertinoActivityIndicator().padding(vertical: 40)
            ],
          AsyncData(:final value) =>
            (value.isSome() ? value.unwrap().appointmentForms : [])
                .map((appointmentForm) => FormInfoWidget(
                      appointmentForm: appointmentForm,
                    ))
                .toList(),
          _ => [const SizedBox()],
        }
            .toColumn(
              separator: const SizedBox(
                height: 10,
              ),
            )
            .padding(all: 10)
            .scrollable(),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: showNewFormModal,
        child: Styled.icon(Icons.add),
      ),
    ));
  }

  void showNewFormModal() {
    showCupertinoModalPopup(
        barrierDismissible: true,
        barrierColor: Colors.black12,
        context: context,
        builder: (ctx) => CoreScreen(
              child: _NewForm(),
            ));
  }
}

class _NewForm extends ConsumerWidget {
  final nameController = TextEditingController();
  final dropDownValue = Rx<String?>(null);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return <Widget>[
      CoreInput(
        isDense: true,
        controller: nameController,
        label: Styled.text("Name your form"),
      ),
      Obx(
        () => CoreDropDown(
            emptyField: true,
            placeholder: "Select a form template (optional)",
            value: dropDownValue.value,
            builder: (ctx, value) => Styled.text(value.toString()),
            items: AppointmentFormState.appointmentForms
                .map((appointmentForm) => appointmentForm.name)
                .toList(),
            onSelected: (value) {
              dropDownValue.value = value;
            }),
      ),
      const SizedBox(
        height: 40,
      ),
      CoreButton(
          onPressed: () {}, child: Styled.text("Save").padding(horizontal: 30)),
    ]
        .toColumn(
          separator: const SizedBox(
            height: 10,
          ),
        )
        .padding(all: 20)
        .backgroundColor(Colors.white)
        .clipRRect(topLeft: 20, topRight: 20)
        .width(MediaQuery.of(context).size.width)
        .height(500);
  }
}
