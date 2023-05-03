import 'package:flutter/material.dart';
import 'package:pharma_go_v2_app/constant/fonts.dart';

class CustomOutLinedButton extends StatelessWidget {
  const CustomOutLinedButton({
    required this.onTap,
    super.key,
  });

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: screenSize.height * .07,
        width: screenSize.width * .7,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: const Color(0xff2a0845),
          ),
        ),
        child: Center(
          child: buttonText('Search'),
        ),
      ),
    );
  }
}
