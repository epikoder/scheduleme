import 'package:flutter/material.dart';
import 'package:scheduleme/utils/assets.dart';
import 'package:styled_widget/styled_widget.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.size = 170});
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.logo,
      height: size,
      width: size,
    ).padding(all: .5).backgroundColor(Colors.black).clipOval();
  }
}
