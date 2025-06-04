import 'package:flutter/material.dart';
import 'package:scheduleme/components/logo.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1),
        () => Compass.pushReplacement("/story-board"));
  }

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
