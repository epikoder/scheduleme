import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class CancelledAppointment extends StatelessWidget {
  const CancelledAppointment({
    super.key,
    this.dateTime,
  });
  final DateTime? dateTime;

  Future fetchData() async {
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.value();
      },
      child: FutureBuilder(
        future: fetchData(),
        builder: (ctx, snapshot) => switch (snapshot.connectionState) {
          ConnectionState.done => [
              Styled.text("Hello Home"),
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.center),
          ConnectionState.waiting =>
            const CupertinoActivityIndicator().center(),
          _ => [
              Styled.text("Something went wrong"),
            ].toColumn().center()
        },
      ),
    );
  }
}
