import 'package:flutter/material.dart';
import 'package:scheduleme/components/parallex_slide.dart';
import 'package:scheduleme/components/translate.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/utils/assets.dart';
import 'package:styled_widget/styled_widget.dart';

class StoryBoardScreen extends StatefulWidget {
  const StoryBoardScreen({super.key});

  @override
  StoryBoardScreenState createState() => StoryBoardScreenState();
}

class StoryBoardScreenState extends State<StoryBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return const PopScope(
      canPop: false,
      child: ParallexSlide(
        pages: [Story1(), Story2()],
      ),
    );
  }
}

class Story1 extends StatelessWidget {
  const Story1({super.key});

  @override
  Widget build(BuildContext context) {
    return [
      Translate(
        duration: const Duration(seconds: 2),
        end: const Offset(0, -70),
        child: Image.asset(
          Assets.logo,
          height: 170,
        ).center(),
      ),
      Translate(
        duration: const Duration(seconds: 2),
        end: const Offset(0, -50),
        child: [
          Styled.text("Welcome to scheduleme")
              .fontSize(16)
              .textColor(Colors.black),
          Styled.text("Get started")
              .fontSize(18)
              .textColor(Colors.white)
              .padding(horizontal: 20, vertical: 5)
              .ripple()
              .backgroundColor(Colors.black87)
              .clipRRect(all: 20)
              .gestures(
                  onTap: () => ParallexSlideController.of(context)!.next())
        ].toColumn(
            separator: const SizedBox(
          height: 10,
        )),
      ).positioned(
        bottom: 30,
      )
    ]
        .toStack(alignment: Alignment.center)
        .height(MediaQuery.of(context).size.height)
        .width(MediaQuery.of(context).size.width)
        .backgroundColor(Colors.white);
  }
}

class Story2 extends StatelessWidget {
  const Story2({super.key});

  @override
  Widget build(BuildContext context) {
    return <Widget>[
      [
        Styled.text("Don't miss an appointment ever again.")
            .textColor(Colors.black)
            .fontSize(18)
      ].toRow(),
      [
        Styled.text("Your \nSchedule")
            .textColor(Colors.black)
            .fontSize(42)
            .fontWeight(FontWeight.bold)
      ].toRow(),
      Image.asset(Assets.calender),
      [
        Styled.text("Sun, 09 Jyly").textColor(Colors.black),
        Styled.text("09").fontSize(90).textColor(Colors.orange.shade800),
      ].toRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween),
      [
        Image.asset(
          Assets.logo,
          height: 50,
        ),
        Styled.text("25").fontSize(90).textColor(Colors.orange.shade800),
      ].toRow(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween),
      Styled.text("Continue")
          .fontSize(18)
          .textColor(Colors.white)
          .padding(horizontal: 40, vertical: 5)
          .ripple()
          .backgroundColor(Colors.black87)
          .clipRRect(all: 20)
          .gestures(onTap: () => Compass.pushReplacement("/login"))
          .padding(vertical: 10)
    ]
        .toColumn(
            mainAxisAlignment: MainAxisAlignment.center,
            separator: const SizedBox(
              height: 10,
            ))
        .padding(
          horizontal: 50,
        )
        .height(MediaQuery.of(context).size.height)
        .width(MediaQuery.of(context).size.width)
        .backgroundColor(Colors.white);
  }
}
