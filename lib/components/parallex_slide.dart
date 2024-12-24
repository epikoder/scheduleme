import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class ParallexSlide extends StatefulWidget {
  const ParallexSlide({super.key, required this.pages});
  final List<Widget> pages;

  @override
  State<ParallexSlide> createState() => _ParallexSlideState();
}

class _ParallexSlideState extends State<ParallexSlide> {
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: PageView.builder(
        clipBehavior: Clip.none,
        controller: pageController,
        itemCount: widget.pages.length,
        itemBuilder: (context, index) {
          // double offset = pageOffset - index;
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double pageOffset = 0;
              if (pageController.position.haveDimensions) {
                pageOffset = pageController.page! - index;
              }
              double gauss =
                  math.exp(-(math.pow((pageOffset.abs() - 0.8), 2) / 0.08));
              return Transform.translate(
                offset: Offset(-10 * gauss * pageOffset.sign, 0),
                child: Container(
                  clipBehavior: Clip.none,
                  margin: const EdgeInsets.only(
                    left: 4,
                    right: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.8),
                        // offset: const Offset(8, 20),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    child: FittedBox(
                      fit: BoxFit.none,
                      alignment: Alignment(-pageOffset.abs(), 0),
                      child: ParallexSlideController(
                          controller: pageController,
                          child: widget.pages[index]),
                    ),
                  ).width(double.infinity).height(double.infinity),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ParallexSlideController extends InheritedWidget {
  final PageController controller;

  const ParallexSlideController(
      {super.key, required this.controller, required super.child});

  static ParallexSlideController? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ParallexSlideController>();
  }

  void prev() => controller.previousPage(
      duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  void next() => controller.nextPage(
      duration: const Duration(milliseconds: 500), curve: Curves.decelerate);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
