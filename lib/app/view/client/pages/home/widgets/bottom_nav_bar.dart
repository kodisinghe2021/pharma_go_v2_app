import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/widgets/top_bar.dart';
import 'package:pharma_go_v2_app/app/view_model/client/home/home_controller.dart';

class HomeBottomNavBar extends StatelessWidget {
  HomeBottomNavBar({
    super.key,
  });

  final HomeController _controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      height: screenSize.height * .08,
      decoration: BoxDecoration(color: Colors.amber.withOpacity(.4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // capture image
          TextIconButton(
            iconData: Bootstrap.camera_fill,
            text: "Capture Note",
            onTap: () async {
              //clear readad data
              _controller.isTextExtracted.value = false;

              await _controller.setImageFilePath(ImageSource.camera);
            },
          ),

          // select image from galary
          TextIconButton(
            onTap: () async {
              _controller.isTextExtracted.value = false;

              await _controller.setImageFilePath(ImageSource.gallery);
            },
            iconData: Bootstrap.image_fill,
            text: "Select from \n Gallery",
          ),

          //----------- open readed text
          Obx(
            () => IconButton(
              onPressed: () async {
                _controller.readingText.value = true;
                await _controller.extractTextFromImage();
                _controller.readingText.value = false;
              },
              icon: _controller.readingText.value
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Icon(Bootstrap.search),
            ),
          ),

          //------------ open pharmacy list for orders
          IconButton(
            onPressed: () async {
              _controller.isPharmacyOpen.value =
                  !_controller.isPharmacyOpen.value;
                  
            },
            icon: _controller.isReading.value
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const Icon(Bootstrap.menu_down),
          ),
        ],
      ),
    );
  }
}
