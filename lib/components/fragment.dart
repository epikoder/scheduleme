import 'package:flutter/material.dart';
import 'package:scheduleme/core_widgets/core_widget.dart';

class FragmentController extends ValueNotifier<int> {
  FragmentController(super.value);
}

class FragmentProvider extends InheritedWidget {
  FragmentProvider({
    super.key,
    required this.controller,
    required this.children,
  }) : super(
            child: _ResolveFragment(
          controller: controller,
          children: children,
        ));

  final List<Fragment> children;
  final FragmentController controller;

  static FragmentProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FragmentProvider>();
  }

  @override
  bool updateShouldNotify(FragmentProvider oldWidget) {
    return controller.value != oldWidget.controller.value;
  }
}

class _ResolveFragment extends StatelessWidget {
  const _ResolveFragment({required this.controller, required this.children});

  final List<Fragment> children;
  final FragmentController controller;

  @override
  Widget build(BuildContext context) {
    final controller = FragmentProvider.of(context)!.controller;
    return ValueListenableBuilder<int>(
      valueListenable: controller,
      builder: (context, value, child) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(-1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        child: children[value],
      ),
    );
  }
}

abstract class Fragment extends CoreStatelessWidget {
  const Fragment({super.key});

  void navigate(BuildContext context, int nav) {
    final controller = FragmentProvider.of(context)!.controller;
    controller.value = nav;
  }
}
