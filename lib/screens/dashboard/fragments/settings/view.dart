import 'package:flutter/material.dart';
import 'package:scheduleme/components/fragment.dart';
import 'package:styled_widget/styled_widget.dart';

class SettingFragment extends Fragment {
  const SettingFragment({super.key});

  @override
  Widget createAndroidWidget(context, ref) {
    return <Widget>[
      [Styled.text("Application Setting")].toRow()
    ].toColumn().padding(horizontal: 10).backgroundColor(Colors.white);
  }

  @override
  Widget createIosWidget(context, ref) {
    return createAndroidWidget(context, ref);
  }
}
