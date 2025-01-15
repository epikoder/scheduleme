import 'package:flutter/material.dart';
import 'package:scheduleme/components/fragment.dart';
import 'package:styled_widget/styled_widget.dart';

class ProfileScreen extends Fragment {
  const ProfileScreen({super.key});

  @override
  Widget createAndroidWidget(BuildContext context) {
    return <Widget>[Styled.text("Profilecreen")].toColumn();
  }

  @override
  Widget createIosWidget(BuildContext context) {
    // TODO: implement createIosWidget
    throw UnimplementedError();
  }
}
