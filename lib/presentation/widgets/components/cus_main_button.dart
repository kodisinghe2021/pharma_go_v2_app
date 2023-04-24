import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pharma_go_v2_app/constant/colurs.dart';
import 'package:pharma_go_v2_app/controllers/anim/button_anim.dart';

class CutomMainButton extends StatelessWidget {
   CutomMainButton({
    required this.onTap,
    this.isLoading = false,
    super.key,
  });
 final ButtonAnimController _animController = ButtonAnimController();
  final Function() onTap;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(
        () => AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: buttonGradient(),
            border: Border.all(
              width: 1,
              color: Colors.white.withOpacity(.8),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0XFFFFEFBA).withOpacity(.5),
                blurRadius: _animController.blurRadius.value,
                spreadRadius: _animController.spreadRadius.value,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(
                    color: kLowWhite,
                  )
                : Text(
                    'Sign In',
                    style: GoogleFonts.ubuntu(
                      fontSize: 30,
                      color: kLowWhite,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
