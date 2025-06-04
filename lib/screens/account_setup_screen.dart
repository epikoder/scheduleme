import 'package:flutter/material.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:styled_widget/styled_widget.dart';

class AccountSetupScreen extends StatefulWidget {
  const AccountSetupScreen({super.key});

  @override
  AccountSetupScreenState createState() => AccountSetupScreenState();
}

class AccountSetupScreenState extends State<AccountSetupScreen> {
  @override
  Widget build(BuildContext context) {
    return CoreScreen(
      child: PopScope(
        canPop: false,
        child: const Logo().center(),
      ),
    );
  }
}
