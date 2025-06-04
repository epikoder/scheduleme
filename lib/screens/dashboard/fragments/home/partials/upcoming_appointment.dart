import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:option_result/option_result.dart';
import 'package:scheduleme/components/appointment/appointment_card.dart';
import 'package:scheduleme/services/space/appointment/appointment.dart';
import 'package:scheduleme/services/space/appointment/model.dart';
import 'package:styled_widget/styled_widget.dart';

const viewIndex = 1;

class UpcomingAppointment extends ConsumerStatefulWidget {
  const UpcomingAppointment({
    super.key,
    this.dateTime,
  });
  final ValueNotifier<DateTime>? dateTime;

  @override
  UpcomingAppointmentState createState() => UpcomingAppointmentState();
}

class UpcomingAppointmentState extends ConsumerState<UpcomingAppointment> {
  Future<void> fetchData() async {
    ref.read(getAppointmentProvider.notifier).getAppointment(
        status: AppointmentStatus.upcoming, dateTime: widget.dateTime?.value);
  }

  @override
  initState() {
    super.initState();
    Future.microtask(() {
      // ignore: use_build_context_synchronously
      // final controller = DefaultTabController.maybeOf(context);
      // controller!.addListener(() {
      //   if (mounted && controller.index == viewIndex) {
      //     ref.read(getAppointmentProvider.notifier).getAppointment(
      //         status: AppointmentStatus.upcoming,
      //         dateTime: widget.dateTime!.value);
      //   }
      // });

      widget.dateTime?.addListener(() {
        if (mounted) {
          ref
              .read(getAppointmentProvider.notifier)
              .getAppointment(dateTime: widget.dateTime!.value);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getAppointmentProvider);
    return RefreshIndicator(
      onRefresh: fetchData,
      child: switch (state) {
        AsyncData(:final value) => switch (value) {
            Some(:final value) => switch (value.appointments.isNotEmpty) {
                true => value.appointments
                    .where((appointment) =>
                        appointment.status == AppointmentStatus.scheduled ||
                        appointment.status == AppointmentStatus.rescheduled)
                    .map((appointment) => AppointmentCard(
                          appointment: appointment,
                        ))
                    .toList()
                    .toColumn(),
                false => <Widget>[Styled.text("Nothing here")].toColumn(
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
              },
            None() => <Widget>[].toColumn()
          },
        AsyncLoading() => const CupertinoActivityIndicator().center(),
        _ => [
            Styled.text("Something went wrong"),
          ].toColumn().center()
      },
    );
  }
}
