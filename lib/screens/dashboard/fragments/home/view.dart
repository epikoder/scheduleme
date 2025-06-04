import 'dart:async';

import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/state_manager.dart';
import 'package:option_result/option_result.dart';
import 'package:scheduleme/components/appointment/appointment_card.dart';
import 'package:scheduleme/components/fragment.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/date_nav.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/cancelled_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/expired_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/recent_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/upcoming_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/state.dart';
import 'package:scheduleme/services/space/appointment/appointment.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeFragment extends StatefulFragment {
  const HomeFragment({super.key});

  @override
  HomeFragmentState createState() => HomeFragmentState();
}

class HomeFragmentState extends FragmentState<HomeFragment> {
  final currentDate = ValueNotifier<DateTime>(DateTime.now());
  final focusNode = FocusNode();

  @override
  initState() {
    super.initState();
    Future.microtask(() async {
      ref
          .read(getAppointmentProvider.notifier)
          .getAppointment(dateTime: currentDate.value);

      focusNode.addListener(() {
        HomeState.searchBarFocused.value = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    currentDate.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Timer? _debounce;
  void debounce(String keyword) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      ref.read(findAppointmentProvider.notifier).findAppointment(keyword);
    });
  }

  @override
  Widget createAndroidWidget(context, ref) {
    return LayoutBuilder(
      builder: (ctx, constraints) => [
        <Widget>[
          CoreInput(
            isDense: true,
            placeholder: "Find appointment",
            focusNode: focusNode,
            onChanged: debounce,
          ).padding(horizontal: 10),
          DateNav(date: currentDate),
          DefaultTabController(
            length: 4,
            initialIndex: 1,
            child: [
              const SizedBox(
                height: 40,
                child: SegmentedTabControl(
                  textStyle: TextStyle(fontSize: 12),
                  selectedTabTextColor: Colors.black,
                  tabTextColor: Colors.grey,
                  barDecoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  tabs: [
                    SegmentTab(
                      label: "Recent",
                      color: Colors.transparent,
                    ),
                    SegmentTab(
                      label: "Upcoming",
                      color: Colors.transparent,
                    ),
                    SegmentTab(
                      label: "Expired",
                      color: Colors.transparent,
                    ),
                    SegmentTab(
                      label: "Cancelled",
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TabBarView(
                children: [
                  RecentAppointment(
                    dateTime: currentDate,
                  ),
                  UpcomingAppointment(
                    dateTime: currentDate,
                  ),
                  ExpiredAppointment(
                    dateTime: currentDate,
                  ),
                  CancelledAppointment(
                    dateTime: currentDate,
                  ),
                ],
              )
                  .padding(horizontal: 10)
                  .backgroundColor(Colors.white)
                  .clipRRect(all: 20)
                  .expanded(flex: 1)
            ].toColumn(),
          ).height(constraints.maxHeight - 100)
        ].toColumn(
          separator: const SizedBox(height: 10),
        ),
        Obx(() => HomeState.searchBarFocused.value
            ? _Result().card(elevation: 5).positioned(top: 40)
            : const SizedBox()),
      ].toStack(),
    );
  }

  @override
  Widget createIosWidget(context, ref) {
    return createAndroidWidget(context, ref);
  }
}

class _Result extends ConsumerStatefulWidget {
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends ConsumerState<_Result> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(findAppointmentProvider);
    ref.listen(findAppointmentProvider, (_, value) {
      switch (value) {
        case AsyncData(:final value):
          if (value.isSome()) {
            HomeState.findAppointmentHistory.value =
                value.unwrap().appointments;
          }
          break;
        default:
      }
    });

    return (switch (state) {
      AsyncLoading() => [const CupertinoActivityIndicator().height(100)],
      AsyncData(:final value) => switch (value) {
          Some(:final value) => value.appointments
              .map((app) => AppointmentCard(appointment: app))
              .toList(),
          None() => HomeState.findAppointmentHistory
              .map((app) => AppointmentCard(appointment: app))
              .toList(),
        },
      _ => [const SizedBox()],
    })
        .toColumn()
        .scrollable()
        .constrained(
            minHeight: state.isLoading ? 100 : 0,
            maxHeight: MediaQuery.of(context).size.height * .7)
        .width(MediaQuery.of(context).size.width - 30)
        .padding(horizontal: 10);
  }
}
