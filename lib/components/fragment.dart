import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FragmentController extends ValueNotifier<int> {
  FragmentController(super.value);
}

class FragmentProvider extends InheritedWidget {
  FragmentProvider({
    super.key,
    required this.controller,
    required this.children,
  })  : _pageController = PageController(initialPage: controller.value),
        super(
          child: _ResolveFragment(
            controller: controller,
            children: children,
          ),
        );

  final List<NavigableFragment> children;
  final FragmentController controller;
  final PageController _pageController;

  static FragmentProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FragmentProvider>();
  }

  PageController get pageController => _pageController;

  @override
  bool updateShouldNotify(FragmentProvider oldWidget) {
    return controller.value != oldWidget.controller.value;
  }
}

class _ResolveFragment extends StatefulWidget {
  const _ResolveFragment({required this.controller, required this.children});

  final List<NavigableFragment> children;
  final FragmentController controller;

  @override
  State<_ResolveFragment> createState() => _ResolveFragmentState();
}

class _ResolveFragmentState extends State<_ResolveFragment> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.controller.value);
    widget.controller.addListener(_updatePage);
  }

  void _updatePage() {
    if (_pageController.hasClients) {
      _pageController.animateToPage(
        widget.controller.value,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updatePage);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (index) => widget.controller.value = index,
      children: widget.children as List<Widget>,
    );
  }
}

abstract class NavigableFragment extends Widget {
  const NavigableFragment({super.key});

  void navigate(BuildContext context, int index);
}

abstract class Fragment extends ConsumerWidget implements NavigableFragment {
  const Fragment({super.key});

  Widget createIosWidget(BuildContext context, WidgetRef ref);
  Widget createAndroidWidget(BuildContext context, WidgetRef ref);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Platform.isIOS
        ? createIosWidget(context, ref)
        : createAndroidWidget(context, ref);
  }

  @override
  void navigate(BuildContext context, int index) {
    final provider = FragmentProvider.of(context)!;
    provider.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    provider.controller.value = index;
  }
}

abstract class StatefulFragment extends ConsumerStatefulWidget
    implements NavigableFragment {
  const StatefulFragment({super.key});

  @override
  void navigate(BuildContext context, int index) {
    final provider = FragmentProvider.of(context)!;
    provider.pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    provider.controller.value = index;
  }
}

abstract class FragmentState<T extends StatefulFragment>
    extends ConsumerState<T> {
  Widget createIosWidget(BuildContext context, WidgetRef ref);
  Widget createAndroidWidget(BuildContext context, WidgetRef ref);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? createIosWidget(context, ref)
        : createAndroidWidget(context, ref);
  }
}
