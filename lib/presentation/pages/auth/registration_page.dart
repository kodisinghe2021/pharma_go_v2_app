import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/constant/box_shadows.dart';
import 'package:pharma_go_v2_app/constant/colurs.dart';
import 'package:pharma_go_v2_app/controllers/auth/registration_controller.dart';
import 'package:pharma_go_v2_app/presentation/widgets/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/presentation/widgets/components/cus_main_button.dart';
import 'package:pharma_go_v2_app/presentation/widgets/components/text_field.dart';
import 'package:pharma_go_v2_app/presentation/widgets/components/text_icon_button.dart';
import 'package:pharma_go_v2_app/presentation/widgets/screen/custom_heading.dart';
import 'package:pharma_go_v2_app/routes/app_pages.dart';

class RegistrationPage extends GetView<RegistrationController> {
  RegistrationPage({super.key});
  final Location _location = Location.instance;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SizedBox(
            height: screenSize.height * 1.1,
            width: screenSize.width,
            child: Stack(
              children: [
                //^ background Container
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    gradient: backGroundGradient(),
                  ),
                ),
                //^ Form
                Positioned(
                  top: screenSize.height * .2,
                  child: Obx(
                    () => Container(
                      width: screenSize.width,
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height * .1,
                            //    color: Colors.redAccent,
                            child: CustomTextField(
                              controller: controller.name,
                              labelText: 'Your name here',
                              suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(Bootstrap.mailbox2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: screenSize.height * .1,
                            //    color: Colors.redAccent,
                            child: CustomTextField(
                              controller: controller.mobile,
                              labelText: 'Phone number here',
                              suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(Bootstrap.mailbox2),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                                          await controller.getLocationdetails();
                                          await controller.getAddress();
                                          //await controller.geoLocationAll();
                                          Logger()
                                              .i("location function executed");
                                          Logger()
                                              .i(controller.longitude.value);
                                          Logger().i(controller.latitude.value);
                                          controller.isLocationLoading.value =
                                              false;
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
                                                "Set my current location",
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
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: screenSize.height * .1,
                            child: SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenSize.width * .5,
                                    //    color: Colors.redAccent,
                                    child: CustomTextField(
                                      controller: controller.adNumber,
                                      labelText: 'Post number',
                                      suffix: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Bootstrap.mailbox2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * .9,
                                    //    color: Colors.redAccent,
                                    child: CustomTextField(
                                      controller: controller.adStreet,
                                      labelText: 'Street here',
                                      suffix: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Bootstrap.mailbox2),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: screenSize.width * .9,
                                    //    color: Colors.redAccent,
                                    child: CustomTextField(
                                      controller: controller.adCity,
                                      labelText: 'City here',
                                      suffix: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Bootstrap.mailbox2),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
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
                          SizedBox(
                            height: screenSize.height * .1,
                            //    color: Colors.redAccent,
                            child: CustomTextField(
                              controller: controller.password,
                              labelText: 'Passward here',
                              suffix: IconButton(
                                onPressed: () {},
                                icon: const Icon(Bootstrap.mailbox2),
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
                                    child: CircularProgressIndicator())
                                : CutomMainButton(
                                    text: "Register",
                                    onTap: () async {
                                      waitingDialogBox();
                                      await controller.login();
                                      if (controller.isSuccessed.value) {
                                        Logger().i(
                                            'uID - ${controller.getStorage.read('uID')} | email - ${controller.getStorage.read('email')}');
                                      } else {
                                        Logger().e(
                                            'Error - ${controller.getStorage.read('error')}');
                                      }
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //^ Header
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
                    title: "Happy to join",
                    text: "Don’t warry. \nyour details are secure with us",
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: TextIconButton(
                    icon: const Icon(
                      HeroIcons.arrow_right,
                      size: 40,
                      color: Colors.white,
                    ),
                    text: "Already have account? Login here",
                    onTap: () {
                      Logger().d("Tapped");
                      Get.toNamed(Routes.LOGIN);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

OnBoardingSlider slider(Size screenSize, TextEditingController controller) =>
    OnBoardingSlider(
      headerBackgroundColor: Colors.amber,
      finishButtonText: 'Register',
      finishButtonStyle: const FinishButtonStyle(
        backgroundColor: Colors.black,
      ),
      skipTextButton: const Text('Skip'),
      trailing: const Text('Login'),
      background: [
        SizedBox(
          height: screenSize.height * .1,
          //    color: Colors.redAccent,
          child: CustomTextField(
            controller: controller,
            labelText: 'Passward here',
            suffix: IconButton(
              onPressed: () {},
              icon: const Icon(Bootstrap.mailbox2),
            ),
          ),
        ),
        Container(
          color: Colors.white12,
          width: 100,
          height: 100,
        ),
      ],
      totalPage: 2,
      speed: 1.8,
      pageBodies: [
        SizedBox(
          height: screenSize.height * .1,
          //    color: Colors.redAccent,
          child: CustomTextField(
            controller: controller,
            labelText: 'Passward here',
            suffix: IconButton(
              onPressed: () {},
              icon: const Icon(Bootstrap.mailbox2),
            ),
          ),
        ),
        SizedBox(
          height: screenSize.height * .1,
          //    color: Colors.redAccent,
          child: CustomTextField(
            controller: controller,
            labelText: 'Passward here',
            suffix: IconButton(
              onPressed: () {},
              icon: const Icon(Bootstrap.mailbox2),
            ),
          ),
        ),
      ],
    );
