import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scheduleme/components/app_bar.dart';
import 'package:scheduleme/components/floating_back_button.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/input.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

class UserInviteScreen extends ConsumerStatefulWidget {
  const UserInviteScreen({super.key});

  @override
  UserInviteScreenState createState() => UserInviteScreenState();
}

class UserInviteScreenState extends ConsumerState<UserInviteScreen> {
  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: Scaffold(
        appBar: appBar("Invite Member", actions: [
          IconButton(
            // TODO: admin priviledge
            onPressed: () => Compass.push("/users/invite/edit"),
            style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(ExtColor.buttonColor),
              padding: WidgetStatePropertyAll(EdgeInsets.all(5)),
              minimumSize: WidgetStatePropertyAll(Size(30, 30)),
            ),
            iconSize: 20,
            icon: Styled.icon(
              Icons.settings,
            ),
          )
        ]),
        body: <Widget>[
          CoreInput(
            placeholder: "Enter email address",
            isDense: true,
            validator: (value) => null,
          )
        ]
            .toColumn(
              separator: const SizedBox(
                height: 20,
              ),
            )
            .padding(all: 10)
            .scrollable(),
      ),
    );
  }
}
