import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Text buttonText(String text) => Text(
      text,
      style: GoogleFonts.fahkwang(
        color: const Color(0xff2a0845),
        fontWeight: FontWeight.bold,
      ),
    );

FittedBox cardText(
  String text, {
  vertical = 0.0,
  horizontal = 0.0,
}) =>
    FittedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: vertical,
          horizontal: horizontal,
        ),
        child: Text(
          text,
          style: GoogleFonts.roboto(color: const Color(0xFFD3CCE3)),
        ),
      ),
    );
