import 'package:flutter/material.dart';

class NoteContainer extends StatelessWidget {
  const NoteContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          width: 1,
          color: const Color(0xff2a0845),
        ),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFabbaab),
            Color(0xFFffffff),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(.3),
            offset: const Offset(-1, 1),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      width: screenSize.width * .8,
      height: screenSize.height * .4,
      child: child,
    );
  }
}
