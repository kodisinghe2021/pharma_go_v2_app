// import 'dart:ui';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/button/icon_buttons/text_icon_button.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/button/main_buttons/cus_main_button.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/button/main_buttons/goole_button.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/text_fields/text_field.dart';
import 'package:pharma_go_v2_app/app/view/client/components/screen/custom_heading.dart';
import 'package:pharma_go_v2_app/app/view_model/client/auth/login_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/colurs.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';

class ClientLoginPage extends GetView<ClientLoginController> {
  ClientLoginPage({super.key});
  @override
  ClientLoginController controller = Get.put(ClientLoginController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            //^ background Container
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: backGroundGradient(),
              ),
            ),
            //^ second layer
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Obx(
                  () => Column(
                    children: [
                      //^ header
                      SizedBox(
                        height: screenSize.height * .4,
                        width: screenSize.width,
                        // color: Colors.greenAccent,
                        child: const CustomHeding(
                          title: "Im Client!",
                          text: "Welcome back you've\n been missed!",
                        ),
                      ),

                      //^ social Login
                      SizedBox(
                        height: screenSize.height * .1,
                        // color: Colors.blueAccent,
                        child: GoogleLoginButton(
                          onTap: () {},
                        ),
                      ),
                      //^ Form
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: Container(
                            height: screenSize.height * .4,
                            decoration: BoxDecoration(
                              gradient: glassGrasdient(),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  height: screenSize.height * .1,
                                  //    color: Colors.redAccent,
                                  child: CustomTextField(
                                    controller: controller.email,
                                    labelText: 'Email here',
                                    suffix: IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Bootstrap.mailbox2),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: screenSize.height * .1,
                                  //  color: Colors.redAccent,
                                  child: CustomTextField(
                                    isObsecure: controller.isObsecure.value,
                                    controller: controller.password,
                                    labelText: 'Password here',
                                    suffix: IconButton(
                                      onPressed: () {
                                        controller.isObsecure.value =
                                            !controller.isObsecure.value;
                                      },
                                      icon: controller.isObsecure.value
                                          ? const Icon(Bootstrap.eye_slash_fill)
                                          : const Icon(Bootstrap.eye_fill),
                                    ),
                                  ),
                                ),
                                //* Login Button
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 5,
                                  ),
                                  height: screenSize.height * .1,
                                  //   color: Colors.redAccent,
                                  child: controller.isLoading.value
                                      ? const Center(
                                          child: CircularProgressIndicator())
                                      : CutomMainButton(
                                          text: "Sign In",
                                          onTap: () async {
                                            controller.isLoading.value = true;
                                            await controller.login();
                                            controller.isLoading.value = false;
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //^ Move to registration button
            Positioned(
              top: screenSize.height * .32,
              child: LoginTextIconButton(
                icon: const Icon(
                  HeroIcons.arrow_right,
                  size: 40,
                  color: Colors.white,
                ),
                text: "Haven't account? Register here",
                onTap: () {
                  Logger().d("Tapped");
                  Get.toNamed(Routes.CLIENTREGISTRATION);
                },
              ),
            ),

            // navigate to pharmacy side
            TextButton(
              onPressed: () {
                Get.offAllNamed(Routes.PHARMALOGIN);
              },
              child: Text(
                "I'm pharmacy..",
                style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
