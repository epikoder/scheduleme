import 'package:flutter/widgets.dart';

class Translate extends StatefulWidget {
  const Translate({
    super.key,
    required this.child,
    this.start,
    required this.end,
    required this.duration,
    this.delay,
  });
  final Widget child;
  final Offset? start;
  final Offset end;
  final Duration duration;
  final Duration? delay;

  @override
  TranslateState createState() => TranslateState();
}

class TranslateState extends State<Translate>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.start ?? const Offset(0, 0),
      end: widget.end,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    Future.delayed(widget.delay ?? const Duration(microseconds: 0), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: _animation.value, // Apply translation
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
