import 'dart:math';

import 'package:flutter/material.dart';
class AuthHome extends StatelessWidget {
  const AuthHome({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
class FlipAnim extends StatefulWidget {
  const FlipAnim({
    required this.front,
    required this.back,
    super.key,
  });
  final Widget front;
  final Widget back;
  @override
  State<FlipAnim> createState() => _FlipAnimState();
}

class _FlipAnimState extends State<FlipAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isFront = true;
  double dragPosition = 0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    controller.addListener(() {
      setState(() {
        dragPosition = animation.value;
        setImageSide();
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double angle = dragPosition / 180 * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);

    return GestureDetector(
      onHorizontalDragUpdate: (details) => setState(() {
        print(details);
        {
          dragPosition -= details.delta.dx;
          dragPosition %= 360;
          setImageSide();
        }
      }),
      onHorizontalDragEnd: (details) {
        final double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;
        animation = Tween<double>(
          begin: dragPosition,
          end: end,
        ).animate(controller);
        controller.forward(from: 0);
      },
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: isFront
            ? widget.front
            : Transform(
                transform: Matrix4.identity()..rotateX(pi),
                alignment: Alignment.center,
                child: widget.back,
              ),
      ),
    );
  }

  void setImageSide() {
    if (dragPosition <= 90 || dragPosition >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
