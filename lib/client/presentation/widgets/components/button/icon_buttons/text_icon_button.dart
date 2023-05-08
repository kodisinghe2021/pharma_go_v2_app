import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_go_v2_app/client/constant/colurs.dart';

class LoginTextIconButton extends StatelessWidget {
  const LoginTextIconButton({
    required this.onTap,
    required this.text,
    required this.icon,
    super.key,
  });

  final Function() onTap;
  final String text;
  final Widget icon;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SizedBox(
      width: screenSize.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            text,
            style: GoogleFonts.b612(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0A4D68),
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              //   width: 200,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: atlas(),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(5, 10),
                    blurRadius: 20,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(.4),
                  )
                ],
              ),
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}
