import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:option_result/option_result.dart';
import 'package:scheduleme/components/fragment.dart';
import 'package:scheduleme/constants/color.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';
import 'package:scheduleme/core_widgets/screen.dart';
import 'package:scheduleme/screens/dashboard/fragments/home/view.dart';
import 'package:scheduleme/screens/dashboard/fragments/settings/view.dart';
import 'package:scheduleme/services/navigation.service.dart';
import 'package:scheduleme/services/space/appointment/appointment.dart';
import 'package:scheduleme/services/space/model.dart';
import 'package:scheduleme/services/space/space.dart';
import 'package:scheduleme/utils/logger.dart';
import 'package:scheduleme/utils/toast.dart';
import 'package:styled_widget/styled_widget.dart';

Color bgColor(BuildContext context) {
  return const Color.fromARGB(255, 249, 248, 244);
}

class DashboardScreen extends CoreStatefulWidget {
  const DashboardScreen({super.key});

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends CoreWidgetState<DashboardScreen> {
  final controller = FragmentController(0);
  final scaffoldKey = GlobalKey<ScaffoldState>();

  Option<SpacePartedInfo> selectedSpace = const None();

  @override
  Widget createAndroidWidget(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      Future.microtask(() {
        ref.read(getSpacesProvider.notifier).getSpace(const None());
      });

      final state = ref.watch(getSpacesProvider);
      ref.listen(getSpacesProvider, (_, value) {
        switch (value) {
          case AsyncData(:final value):
            switch (value) {
              case Ok(:final value):
                {
                  if (value.isNone()) return;
                  final spaces = value.unwrap().spaces;
                  if (selectedSpace.isNone() && spaces.isNotEmpty) {
                    selectedSpace = Some(spaces.first);
                  }
                }
              case Err(:final value):
                showToast(value, context: context);
              default:
            }
        }
      });

      return Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: bgColor(context),
          leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
            icon: Styled.icon(Icons.menu),
          ),
          title: switch (selectedSpace) {
            Some(:final value) => TextButton(
                onPressed: () {
                  switch (state) {
                    case AsyncData(:final value):
                      {
                        var spaces = <SpacePartedInfo>[];
                        if (value.isOk() && value.unwrap().isSome()) {
                          spaces = value.unwrap().unwrap().spaces;
                        }
                        final double height =
                            spaces.isEmpty ? 100 : spaces.length * 55;
                        showCupertinoModalPopup(
                          context: context,
                          barrierDismissible: true,
                          builder: (context) => CoreScreen(
                            child: Container(
                              height: height,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              child: [
                                ...(spaces.isNotEmpty
                                    ? spaces
                                        .map(
                                          (space) => SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: _horizontalMenuButton(
                                              space,
                                              Icons.house,
                                              onPressed: () {
                                                setState(() {
                                                  selectedSpace = Some(space);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ),
                                        )
                                        .toList()
                                    : <Widget>[
                                        Styled.text("No Workspace found")
                                      ])
                              ].toColumn(
                                  separator: const SizedBox(
                                height: 5,
                              )),
                            ),
                          ),
                        );
                      }
                  }
                },
                child: Styled.text(value.title)
                    .fontSize(12)
                    .textColor(Colors.black)),
            _ => const SizedBox(),
          },
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
            children: const <NavigableFragment>[
              HomeFragment(),
              SettingFragment(),
            ],
          ),
        ),
        floatingActionButton: const _FloatingActionButton(),
        extendBody: true,
        resizeToAvoidBottomInset: true,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: _BottomNavigation(controller: controller)
            .backgroundColor(Colors.white),
      );
    });
  }

  @override
  Widget createIosWidget(BuildContext context) {
    return createAndroidWidget(context);
  }

  Widget _horizontalMenuButton(
    SpacePartedInfo space,
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
          Styled.text(space.title)
              .textColor(selectedSpace.isSome() &&
                      selectedSpace.unwrap().id == space.id
                  ? ExtColor.textButtonColor
                  : Colors.black)
              .fontSize(11),
        ].toRow(
          separator: const SizedBox(
            width: 20,
          ),
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    ).padding(horizontal: 5);
  }
}

class _FloatingActionButton extends ConsumerStatefulWidget {
  // ignore: unused_element
  const _FloatingActionButton({this.dateTime});
  final DateTime? dateTime;
  @override
  _FloatingActionButtonState createState() => _FloatingActionButtonState();
}

class _FloatingActionButtonState extends ConsumerState<_FloatingActionButton> {
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
                  if (reload.runtimeType == bool && reload as bool) {
                    ref
                        .read(getAppointmentProvider.notifier)
                        .getAppointment(dateTime: widget.dateTime);
                  }
                });
              }),
              _horizontalMenuButton("Invite Users", Icons.person_add,
                  iconColor: Colors.purple, onPressed: () {
                Navigator.of(ctx).pop();
                Compass.push("/users/invite");
              }),
              [
                _verticalMenuButton("Memo", Icons.note_add_outlined,
                    iconColor: Colors.blue, onPressed: () {
                  Navigator.of(ctx).pop();
                  Compass.push("/memos");
                }).flexible(flex: 1),
                _verticalMenuButton("Reminder", Icons.alarm,
                    iconColor: Colors.amber, onPressed: () {
                  Navigator.of(ctx).pop();
                  Compass.push("/reminders");
                }).flexible(flex: 1),
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

class _BottomNavigation extends StatelessWidget {
  _BottomNavigation({required this.controller});
  final FragmentController controller;
  final List<IconData> iconList = [
    Icons.home,
    Icons.settings,
  ];

  @override
  Widget build(BuildContext context) {
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
        onTap: (index) {
          logger.d("navigating... $index");
          controller.value = index;
        },
      ),
    );
  }
}
