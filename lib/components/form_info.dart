import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/services/space/appointment/model.dart';
import 'package:scheduleme/utils/core/method.dart';
import 'package:scheduleme/utils/toast.dart';
import 'package:styled_widget/styled_widget.dart';

class FormInfoWidget extends StatelessWidget {
  const FormInfoWidget({
    super.key,
    required this.appointmentForm,
  });
  final AppointmentForm appointmentForm;

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      Styled.text(appointmentForm.name),
      Transform.scale(
        scale: .8,
        child: Checkbox(
            value: appointmentForm.isDefault ?? false,
            shape: const CircleBorder(),
            onChanged: (checked) => onPressed(context, checked)),
      )
    ]
        .toRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        )
        .padding(all: 10)
        .ripple()
        .clipRRect(all: 10)
        .card()
        .gestures(
          onTap: () =>
              Compass.push("/spaces/manage/customize_appointment", arguments: {
            "id": appointmentForm.id,
          }),
        );
  }

  void onPressed(BuildContext context, bool? checked) {
    if (appointmentForm.isDefault ?? false) {
      return;
    }

    showCupertinoDialog(
      barrierDismissible: true,
      context: context,
      builder: (
        ctx,
      ) =>
          CupertinoAlertDialog(
        content: Text.rich(
          TextSpan(text: "Set ", children: [
            TextSpan(
                text: appointmentForm.name,
                style: const TextStyle(color: ExtColor.textButtonColor)),
            const TextSpan(text: " as default form"),
          ]),
        ), // modal height
        actions: [
          CupertinoButton(
            onPressed: Navigator.of(ctx).pop,
            child: Styled.text("Cancel").fontSize(14).textColor(Colors.red),
          ),
          CupertinoButton(
            onPressed: () async {
              final result = await applicationMethod.setDefaultAppointmentForm(
                  "space_id", appointmentForm.id);
              // ignore: use_build_context_synchronously
              Navigator.of(ctx).pop();
              if (result.isErr()) {
                showToast("Error changing default form");
                return;
              }
              showToast("Updated successfully");
            },
            child: Styled.text("Continue").fontSize(14).textColor(Colors.green),
          ),
        ],
      ).alignment(
        const Alignment(0.0, 0.7), // align modal
      ),
    );
  }
}
