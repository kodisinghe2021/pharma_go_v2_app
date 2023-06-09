import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/button/icon_buttons/text_icon_button.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/button/main_buttons/cus_main_button.dart';
import 'package:pharma_go_v2_app/app/view/client/components/components/text_fields/text_field.dart';
import 'package:pharma_go_v2_app/app/view/client/components/screen/custom_heading.dart';
import 'package:pharma_go_v2_app/app/view_model/client/auth/registration_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_shadows.dart';
import 'package:pharma_go_v2_app/supports/constant/colurs.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';

class ClientRegistrationPage extends GetView<ClientRegistrationController> {
  ClientRegistrationPage({super.key});

  final Location _location = Location.instance;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),

          //--- registration full page
          child: SizedBox(
            height: screenSize.height * 1.1,
            width: screenSize.width,
            child: Stack(
              children: [
                //--- background Container
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: backGroundGradient(),
                  ),
                ),

                //--- Form
                Positioned(
                  top: screenSize.height * .23,
                  child: Obx(
                    () => Container(
                      width: screenSize.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          //--- name field
                          SizedBox(
                            height: screenSize.height * .1,
                            //    color: Colors.redAccent,
                            child: CustomTextField(
                              controller: controller.name,
                              labelText: 'Your name here',
                              suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(Bootstrap.person),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          //--- contact number field
                          SizedBox(
                            height: screenSize.height * .1,
                            child: CustomTextField(
                              controller: controller.contact,
                              labelText: 'Contact number here',
                              suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(Bootstrap.phone),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          //--- get Location button
                          SizedBox(
                            height: screenSize.height * .1,
                            child: controller.isLocationLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          controller.isLocationLoading.value =
                                              true;
                                          Logger().i("CLicked");
                                          //   await controller.getLocation();
                                          await controller.getLocation();
                                          //await controller.getAddress();
                                          //await controller.geoLocationAll();
                                          Logger()
                                              .i("location function executed");
                                          Logger()
                                              .i(controller.longitude.value);
                                          Logger().i(controller.latitude.value);
                                          controller.isLocationLoading.value =
                                              false;
                                          controller.locationSetted.value =
                                              true;
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20, vertical: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            boxShadow: [
                                              commonShadow(),
                                            ],
                                            gradient: whiteGradiaent(),
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text(
                                                controller.locationSetted.value
                                                    ? "${controller.longitude.value.toStringAsFixed(5)} / ${controller.latitude.value.toStringAsFixed(5)}"
                                                    : "Set my current location",
                                                style:
                                                    GoogleFonts.anekDevanagari(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 17,
                                                ),
                                              ),
                                              const SizedBox(width: 20),
                                              const Icon(
                                                Bootstrap.geo_fill,
                                                color: Colors.redAccent,
                                                size: 30,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 10),

                          //--- nic number field
                          SizedBox(
                            height: screenSize.height * .1,
                            //    color: Colors.redAccent,
                            child: CustomTextField(
                              controller: controller.nic,
                              labelText: 'nic number here',
                              suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(Bootstrap.indent),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          //--- email field
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
                          const SizedBox(height: 10),

                          //--- passward filed
                          SizedBox(
                            height: screenSize.height * .1,
                            child: CustomTextField(
                              isObsecure: controller.isObsecure.value,
                              controller: controller.password,
                              labelText: 'Passward here',
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
                          const SizedBox(height: 10),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            height: screenSize.height * .1,
                            //   color: Colors.redAccent,
                            child: controller.isLoading.value
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CutomMainButton(
                                    text: "Register",
                                    onTap: () async {
                                      Logger().i("wait............");
                                      controller.isLoading.value = true;
                                      await controller.addUser();
                                      controller.isLoading.value = false;
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //--- heading text
                Container(
                  width: screenSize.width,
                  height: screenSize.height * .2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      commonShadow(),
                    ],
                  ),
                  child: const CustomHeding(
                    title: "Im client",
                    text: "Don’t warry. \nyour details are secure with us",
                  ),
                ),

                //---- navigator button to registration
                Align(
                  alignment: Alignment.bottomCenter,
                  child: LoginTextIconButton(
                    icon: const Icon(
                      HeroIcons.arrow_right,
                      size: 40,
                      color: Colors.white,
                    ),
                    text: "Already have account? Login here",
                    onTap: () {
                      Logger().d("Tapped");
                      Get.offAllNamed(Routes.CLIENTLOGIN);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
