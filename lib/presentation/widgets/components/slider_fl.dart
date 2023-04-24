import 'package:flutter/material.dart';
import 'package:sliding_switch/sliding_switch.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return SlidingSwitch(
      value: true,
      width: 250,
      height: 60,
      textOff: 'Login',
      textOn: 'Registration',
      background: Colors.transparent,
      onChanged: (bool value) {
        print(value);
      },
      onSwipe: () {},
      onDoubleTap: () {},
      onTap: () {},
    );
  }
}
