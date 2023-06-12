import 'package:flutter/material.dart';

//~ plain colors
const Color kPrimaryYellow = Color(0XFFF99417);
const Color kLowWhite = Color(0XFFF5F5F5);
const Color kLowBlack = Color(0XFF03001C);
const Color kGlassColur = Color(0xFFFDE2F3);

//~ gradient colurs
//* glass morphism gradint
LinearGradient glassGrasdient() => LinearGradient(
      colors: [
        const Color(0xFFFDC830).withOpacity(.2),
        const Color(0xFFF37335).withOpacity(.5),
        //  Colors.white60.withOpacity(.1),
        //  Colors.white.withOpacity(.5),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

//* login, registration page background gradient
LinearGradient backGroundGradient() => const LinearGradient(
      colors: [
        //  Color(0XFFD797FC),
        //  Color(0XFFDEA0F1),
        Color(0XFFFFEFBA),
        Color(0XFFFFFFFF),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

//* Main Button
LinearGradient buttonGradient() => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF0F2027),
        Color(0xFF203A43),
        Color(0xFF2C5364),
      ],
    );
LinearGradient buttonGradientClick() => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF2C5364),
        Color(0xFF203A43),
        Color(0xFF0F2027),
      ],
    );
LinearGradient whiteGradiaent() => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF7C5FAF),
        Color(0xFF54386C),
      ],
    );
LinearGradient vergineAmerica() => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFF7b4397),
        Color(0xFFdc2430),
      ],
    );
LinearGradient atlas() => const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color(0xFFFEAC5E),
        Color(0xFFC779D0),
        Color(0xFF4BC0C8),
      ],
    );
LinearGradient vimo() => const LinearGradient(
      colors: [Color(0xFF6441A5), Color(0xff2a0845)],
      stops: [0.5, 1.0],
    );
