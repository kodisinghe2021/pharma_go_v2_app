import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/constant/colurs.dart';
import 'package:pharma_go_v2_app/controllers/auth/login_controller.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/presentation/widgets/components/cus_main_button.dart';
import 'package:pharma_go_v2_app/presentation/widgets/components/text_field.dart';
import 'package:pharma_go_v2_app/presentation/widgets/decorations/glass_morphism.dart';
import 'package:pharma_go_v2_app/presentation/widgets/screen/custom_heading.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Container(
              width: screenSize.width,
              height: screenSize.height,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 10),
              decoration: BoxDecoration(
                gradient: backGroundGradient(),
              ),
              child: Column(
                children: [
                  //* heading
                  const Expanded(
                    flex: 1,
                    child: CustomHeding(
                      title: "Hello Again!",
                      text: "Welcome back you've\n been missed!",
                    ),
                  ),
                  //* glass
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          decoration: glassDecoration(),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: CustomTextField(
                                            controller: controller.email,
                                            labelText: 'Email here',
                                            suffix: const Icon(
                                              Icons.email_outlined,
                                              color: Color(0xFF203A43),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Obx(
                                            () => CustomTextField(
                                              controller: controller.password,
                                              isObsecure:
                                                  controller.isObsecure.value,
                                              labelText: 'Passward here',
                                              suffix: IconButton(
                                                onPressed: () {
                                                  controller.isObsecure.value =
                                                      !controller
                                                          .isObsecure.value;
                                                },
                                                icon: Icon(
                                                  controller.isObsecure.value
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color:
                                                      const Color(0xFF203A43),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    // color: Colors.redAccent,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 50,
                                      horizontal: 20,
                                    ),
                                    child: SizedBox(
                                      height: 50,
                                      width: screenSize.width * .7,
                                      child: controller.isLoading.value
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator())
                                          : CutomMainButton(
                                              onTap: () async {
                                                waitingDialogBox();
                                                await controller.login();
                                                if (controller
                                                    .isSuccessed.value) {
                                                  Logger().i(
                                                      'uID - ${controller.getStorage.read('uID')} | email - ${controller.getStorage.read('email')}');
                                                } else {
                                                  Logger().e(
                                                      'Error - ${controller.getStorage.read('error')}');
                                                }
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //* bottom
                  Expanded(
                    flex: 1,
                    child: Container(
                        // color: Colors.amber,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
