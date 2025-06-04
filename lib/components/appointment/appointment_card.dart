import 'package:flutter/material.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/services/space/appointment/model.dart';
import 'package:styled_widget/styled_widget.dart';

class AppointmentCard extends StatefulWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
  });
  final Appointment appointment;

  @override
  AppointmentCardState createState() => AppointmentCardState();
}

class AppointmentCardState extends State<AppointmentCard> {
  @override
  Widget build(BuildContext context) {
    return [
      Styled.text(widget.appointment.id),
      Styled.text(widget.appointment.status.string),
    ].toColumn().ripple().gestures(
          onTap: () => Compass.push(
            "/appointments/view",
            arguments: {"id": widget.appointment.id},
          ),
        );
  }
}
