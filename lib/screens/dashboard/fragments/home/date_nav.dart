import 'package:cr_calendar/cr_calendar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

class DateNav extends StatelessWidget {
  const DateNav({super.key, required this.date});
  final ValueNotifier<DateTime> date;

  @override
  Widget build(BuildContext context) {
    return [
      ValueListenableBuilder(
          valueListenable: date,
          builder: (ctx, value, _) => [
                _BuildDates(
                  dateTime: value,
                  onPressed: (day) {
                    date.value = DateTime.now().add(Duration(days: day));
                  },
                )
                    .scrollable(
                      scrollDirection: Axis.horizontal,
                      controller: ScrollController(initialScrollOffset: .3),
                    )
                    .padding(right: 20)
                    .width(MediaQuery.of(context).size.width * .9)
              ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)),
      [
        Styled.icon(Icons.expand_more)
            .rotate(angle: -91.2)
            .positioned(top: 2.5),
        Styled.icon(Icons.expand_more).positioned(bottom: 2.5),
      ]
          .toStack()
          .padding(horizontal: 10)
          .backgroundGradient(const LinearGradient(colors: [
            Color.fromARGB(113, 255, 255, 255),
            Color.fromARGB(189, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
          ]))
          .width(40)
          .height(40)
          .ripple()
          .clipRRect(all: 10)
          .gestures(onTap: () => Compass.push("/appointments/view"))
          .positioned(right: 0, top: 0),
    ].toStack().padding(horizontal: 10);
  }
}

class _BuildDates extends StatelessWidget {
  const _BuildDates({
    required this.onPressed,
    required this.dateTime,
  });
  final Function(int) onPressed;
  final DateTime dateTime;

  bool isCurrentDay(DateTime date) {
    return DateUtils.isSameDay(date, dateTime);
  }

  bool get markActive => DateUtils.isSameDay(
      DateUtils.dateOnly(DateTime.now()), DateUtils.dateOnly(dateTime));
  @override
  Widget build(BuildContext context) {
    return [
      TextButton(
        onPressed: () => onPressed(0),
        style: ButtonStyle(
            side: WidgetStatePropertyAll(
              BorderSide(
                  color: markActive
                      ? const Color.fromARGB(255, 255, 200, 35)
                      : Colors.black12,
                  width: 1),
            ),
            backgroundColor: const WidgetStatePropertyAll(
              Colors.white,
            ),
            padding: const WidgetStatePropertyAll(
                EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
            minimumSize: const WidgetStatePropertyAll(
              Size(80, 50),
            )),
        child: [
          Styled.text("Today")
              .fontSize(10)
              .textColor(Colors.black)
              .fontWeight(FontWeight.w900),
          Styled.text(weekDay(DateTime.now().weekday))
              .textColor(Colors.black)
              .fontSize(8)
              .fontWeight(FontWeight.w600),
        ].toColumn(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            separator: const SizedBox(
              height: 2,
            )),
      ),
      ...<int>[
        1,
        2,
        3,
        4,
        5,
      ].map(
        (v) => TextButton(
          onPressed: () => onPressed(v),
          style: ButtonStyle(
            side: WidgetStatePropertyAll(
              BorderSide(
                  color: isCurrentDay(DateTime.now().add(Duration(days: v)))
                      ? const Color.fromARGB(255, 255, 200, 35)
                      : Colors.black12,
                  width: 1),
            ),
            backgroundColor: const WidgetStatePropertyAll(
              Colors.white,
            ),
          ),
          child: Styled.text(
                  weekDay(DateTime.now().add(Duration(days: v)).weekday))
              .fontSize(10)
              .textColor(Colors.black),
        ),
      )
    ].toRow(
        mainAxisSize: MainAxisSize.min, separator: const SizedBox(width: 5));
  }
}

String weekDay(int wkday) {
  return switch (wkday) {
    DateTime.monday => "Mon",
    DateTime.tuesday => "Tue",
    DateTime.wednesday => "Wed",
    DateTime.thursday => "Thur",
    DateTime.friday => "Fri",
    DateTime.saturday => "Sat",
    DateTime.sunday => "Sun",
    _ => "",
  };
}
