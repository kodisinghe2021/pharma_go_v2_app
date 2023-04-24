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
    return Column(
      children: [
        Expanded(
          flex: 1,
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
          flex: 1,
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
      ],
    );
  }
}
