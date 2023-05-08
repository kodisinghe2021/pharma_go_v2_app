
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/client/constant/colurs.dart';

class GoogleLoginButton extends StatelessWidget {
  const GoogleLoginButton({
    required this.onTap,
    super.key,
  });
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 5),
              color: const Color(0xFF9793AA).withOpacity(.5),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
          gradient: whiteGradiaent(),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 30,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "SignIn with Google",
              style: GoogleFonts.anekDevanagari(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 20,
              ),
            ),
            Logo(Logos.google),
          ],
        ),
      ),
    );
  }
}
