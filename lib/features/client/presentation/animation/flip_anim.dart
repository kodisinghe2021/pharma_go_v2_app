import 'package:flutter/material.dart';
import 'dart:math' show pi;

class FlipContainer extends StatefulWidget {
  const FlipContainer({
    required this.child,
    super.key,
  });

  final Widget child;
  @override
  State<FlipContainer> createState() => _FlipContainerState();
}

class _FlipContainerState extends State<FlipContainer>
    with SingleTickerProviderStateMixin {
  //^ creating objects
  late AnimationController _controller;
  late Animation _animation;

  //^ initilize State
  @override
  void initState() {
    //* initializing control objects
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    //* initializing animation objects
    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);
    //_controller.repeat();

    super.initState();
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateZ(_animation.value),
        child: child,
      ),
    );
  }
}

