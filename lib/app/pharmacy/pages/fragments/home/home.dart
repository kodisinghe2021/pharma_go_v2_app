import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/client/constant/colurs.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/components/button/main_buttons/cus_main_button.dart';
import 'package:pharma_go_v2_app/app/client/presentation/widgets/components/text_fields/text_field.dart';
import 'package:pharma_go_v2_app/app/pharmacy/controllers/home/home_pharma_con.dart';

class PharmaHome extends GetView<PharmaHomeController> {
  PharmaHome({super.key});
  @override
  PharmaHomeController controller = Get.put(PharmaHomeController());
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
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
                top: screenSize.height * .1,
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
                            controller: controller.medicineName,
                            labelText: 'Medicine name here',
                            suffix: IconButton(
                              onPressed: () {},
                              icon: const Icon(Bootstrap.menu_app),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: screenSize.height * .1,
                          //    color: Colors.redAccent,
                          child: CustomTextField(
                            controller: controller.dosage,
                            labelText: 'dosage here',
                            suffix: IconButton(
                              onPressed: () {},
                              icon: const Text('mg'),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: screenSize.height * .1,
                          //    color: Colors.redAccent,
                          child: CustomTextField(
                            controller: controller.quantity,
                            labelText: 'available quantity here',
                            suffix: IconButton(
                              onPressed: () {},
                              icon: const Icon(Bootstrap.menu_app),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: screenSize.height * .1,
                          child: CustomTextField(
                            controller: controller.price,
                            labelText: 'Price here',
                            suffix: IconButton(
                              onPressed: () {},
                              icon: const Icon(Bootstrap.menu_app),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  text: "Add",
                                  onTap: () async {
                                    controller.isLoading.value = true;
                                    await controller.add();
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
    );
  }
}
