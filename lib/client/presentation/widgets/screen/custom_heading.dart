import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeding extends StatelessWidget {
  const CustomHeding({
    required this.title,
    required this.text,
    super.key,
  });

  final String title;
  final String text;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const Spacer(),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: FittedBox(
              child: Text(
                title,
                style: GoogleFonts.ubuntu(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: FittedBox(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
