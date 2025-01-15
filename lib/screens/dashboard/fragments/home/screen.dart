import 'package:animated_segmented_tab_control/animated_segmented_tab_control.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/components/fragment.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/date_nav.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/cancelled_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/expired_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/recent_appointment.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/partials/upcoming_appointment.dart';
import 'package:styled_widget/styled_widget.dart';

class HomeScreen extends Fragment {
  HomeScreen({super.key});
  final currentDate = ValueNotifier<DateTime>(DateTime.now());

  @override
  Widget createAndroidWidget(BuildContext context) {
    return <Widget>[
      const CoreInput(isDense: true, placeholder: "Find appointment")
          .padding(horizontal: 10),
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
                dateTime: currentDate.value,
              ),
              UpcomingAppointment(
                dateTime: currentDate.value,
              ),
              ExpiredAppointment(
                dateTime: currentDate.value,
              ),
              CancelledAppointment(
                dateTime: currentDate.value,
              ),
            ],
          )
              .padding(horizontal: 10)
              .backgroundColor(Colors.white)
              .clipRRect(all: 20)
              .expanded(flex: 1)
        ].toColumn(),
      ).height(MediaQuery.of(context).size.height - 210)
    ].toColumn(
      separator: const SizedBox(height: 10),
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return createAndroidWidget(context);
  }
}
