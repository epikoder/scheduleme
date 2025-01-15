import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scheduleme/components/fragment.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:scheduleme/core_widgets/scaffold.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/screen.dart';
import 'package:scheduleme/screens/settings/screen.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:styled_widget/styled_widget.dart';

Color bgColor(BuildContext context) {
  return const Color.fromARGB(255, 249, 248, 244);
}

class DashboardScreen extends CoreStatelessWidget {
  DashboardScreen({super.key});
  final controller = FragmentController(0);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget createAndroidWidget(BuildContext context) {
    return CoreScaffold(
      scaffoldKey: scaffoldKey,
      appBar: AppBar(
        backgroundColor: bgColor(context),
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: Styled.icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Styled.icon(Icons.qr_code_rounded),
          )
        ],
      ),
      backgroundColor: bgColor(context),
      drawer: Styled.widget()
          .backgroundColor(Colors.white)
          .width(320)
          .height(MediaQuery.of(context).size.height),
      body: CoreScreen(
        child: FragmentProvider(
          controller: controller,
          children: <Fragment>[
            HomeScreen(),
            const SettingScreen(),
          ],
        ),
      ),
      floatingActionButton: _FloatingActionButton(),
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: _BottomNavigation(controller: controller)
          .backgroundColor(Colors.white),
    ).safeArea();
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return createAndroidWidget(context);
  }
}

class _FloatingActionButton extends StatefulWidget {
  @override
  _FloatingActionButtonState createState() => _FloatingActionButtonState();
}

class _FloatingActionButtonState extends State<_FloatingActionButton> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          isOpen = true;
        });
        showCupertinoModalPopup(
          barrierDismissible: true,
          barrierColor: Colors.black12,
          context: context,
          builder: (ctx) => CoreScreen(
            child: [
              _horizontalMenuButton("Create Appointment", Icons.add,
                  onPressed: () {
                Navigator.of(ctx).pop();
                Compass.push("/appointments/create").then((reload) {
                  print(reload.runtimeType);
                });
              }),
              _horizontalMenuButton("Invite Users", Icons.person_add,
                  iconColor: Colors.purple, onPressed: () {}),
              [
                _verticalMenuButton("Memo", Icons.note_add_outlined,
                        iconColor: Colors.blue, onPressed: () {})
                    .flexible(flex: 1),
                _verticalMenuButton("Reminder", Icons.alarm,
                        iconColor: Colors.amber, onPressed: () {})
                    .flexible(flex: 1),
              ].toRow(
                  separator: const SizedBox(
                width: 10,
              )),
            ]
                .toColumn(
                    separator: const SizedBox(
                  height: 5,
                ))
                .clipRRect(all: 10)
                .padding(all: 10)
                .backgroundColor(Colors.white)
                .clipRRect(all: 10)
                .card(elevation: 10)
                .width(320)
                .height(205), // modal height
          ).alignment(
            const Alignment(0.0, 0.7), // align modal
          ),
        ).then((_) => setState(() {
              isOpen = false;
            }));
      },
      shape: const CircleBorder(),
      child: Styled.icon(Icons.add)
          .padding(all: 10)
          .clipRRect(all: 50)
          .rotate(angle: isOpen ? 1 : 0, animate: true)
          .animate(const Duration(milliseconds: 300), Curves.easeInCubic),
    );
  }

  Widget _horizontalMenuButton(
    String text,
    IconData icon, {
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return LayoutBuilder(
      builder: (ctx, constraint) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(
            Size(constraint.maxWidth, 50),
          ),
          backgroundColor: const WidgetStatePropertyAll(
            Color.fromARGB(255, 242, 242, 242),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: const WidgetStatePropertyAll(
              EdgeInsets.symmetric(vertical: 10, horizontal: 10)),
        ),
        child: [
          Styled.icon(icon, color: iconColor)
              .padding(all: 3)
              .backgroundColor(Colors.white)
              .clipRRect(all: 10),
          Styled.text(text).textColor(Colors.black).fontSize(11),
        ].toRow(
          separator: const SizedBox(
            width: 20,
          ),
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }

  Widget _verticalMenuButton(
    String text,
    IconData icon, {
    required VoidCallback onPressed,
    Color? iconColor,
  }) {
    return LayoutBuilder(
      builder: (ctx, constraint) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          fixedSize: WidgetStatePropertyAll(
            Size(constraint.maxWidth, 65),
          ),
          backgroundColor: const WidgetStatePropertyAll(
            Color.fromARGB(255, 242, 242, 242),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        child: [
          Styled.icon(icon, color: iconColor).padding(all: 3),
          Styled.text(
            text,
          ).textColor(Colors.black).fontSize(11),
        ].toColumn(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        ),
      ),
    );
  }
}

class _BottomNavigation extends CoreStatelessWidget {
  _BottomNavigation({required this.controller});
  final FragmentController controller;
  final List<IconData> iconList = [
    Icons.home,
    Icons.settings,
  ];

  @override
  Widget createAndroidWidget(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (ctx, value, _) => AnimatedBottomNavigationBar(
        icons: iconList,
        activeColor: ExtColor.buttonColor,
        activeIndex: value,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.defaultEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => controller.value = index,
      ),
    );
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return createAndroidWidget(context);
  }
}
