import 'package:flutter/material.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    super.key,
    required this.onTap,
    required this.iconData,
    required this.text,
  });

  final Function() onTap;
  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width * 0.25,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: FittedBox(
              child: IconButton(
                onPressed: onTap,
                icon: Icon(
                  iconData,
                  color: const Color(0xff2a0845),
                ),
              ),
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: FittedBox(
          //     child: buttonText(text),
          //   ),
          // )
        ],
      ),
    );
  }
}
