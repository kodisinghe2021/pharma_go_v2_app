import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/widgets/top_bar.dart';
import 'package:pharma_go_v2_app/app/view_model/client/tabbar_tabs/home/controller/home_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final HomeController _controller = Get.put(HomeController());

  //* build method
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
//------ bottom naviagation bar
      // bottomNavigationBar: HomeBottomNavBar(),
//------ bottom naviagation bar END

//------ Body
      body: Obx(
        () => Stack(
          children: [
            //------------------ Background image
            SizedBox(
              width: screenSize.width,
              height: double.infinity,
              child: Image.asset(
                'assets/images/home.jpg',
                fit: BoxFit.cover,
              ),
            ),
            //------------------------------- selected image
            Positioned(
              top: 30,
              child: Column(
                children: [
                  Visibility(
                    visible: _controller.imageFilePath.value.isNotEmpty &&
                        !_controller.isPharmacyOpen.value,
                    child: SelectedImageViewer(
                        path: _controller.imageFilePath.value),
                  ),

                  const SizedBox(height: 5),

                  // this data will be apear only if text is extracted
                  Visibility(
                    visible: _controller.isTextExtracted.value &&
                        !_controller.isPharmacyOpen.value,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.5),
                      ),
                      width: screenSize.width,
                      height: screenSize.height * .4,
                      child: ListView.builder(
                        itemCount: _controller.extractedCharObjectList().length,
                        itemBuilder: (context, index) => ListTile(
                          leading: Text(
                            _controller.extractedCharObjectList()[index].days
                                .toString(),
                            style: GoogleFonts.acme(
                                fontSize: 15, color: Colors.white),
                          ),
                          title: Text(
                            _controller.extractedCharObjectList()[index].name
                                .toString(),
                            style: GoogleFonts.acme(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            _controller
                                .extractedCharObjectList()[index].dosageInNote
                                .toString(),
                            style: GoogleFonts.acme(
                                fontSize: 15,
                                color:
                                    const Color.fromARGB(255, 222, 216, 216)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ----------------------------------------- toggle view buttons
            Positioned(
              bottom: 10,
              right: 10,
              child: Row(
                children: [
                  // select image from galary
                  SizedBox(
                    width: getscreenSize(context).width * .15,
                    height: getscreenSize(context).height * .07,
                    child: TextIconButton(
                      onTap: () async {
                        _controller.isTextExtracted.value = false;

                        await _controller.setImageFilePath(ImageSource.gallery);
                      },
                      iconData: Bootstrap.image_fill,
                      text: "Select from \n Gallery",
                    ),
                  ),
                  // capture image
                  SizedBox(
                    width: getscreenSize(context).width * .15,
                    height: getscreenSize(context).height * .07,
                    child: TextIconButton(
                      iconData: Bootstrap.camera_fill,
                      text: "Capture Note",
                      onTap: () async {
                        //clear readad data
                        _controller.isTextExtracted.value = false;

                        await _controller.setImageFilePath(ImageSource.camera);
                      },
                    ),
                  ),
                  Visibility(
                    visible: _controller.isTextExtracted.value,
                    child: GlassButton(
                      text: "Show Pharmacies",
                      onTap: () => Get.toNamed(Routes.PHARMACYLIST),
                    ),
                  ),
                  Visibility(
                    visible: !_controller.isTextExtracted.value,
                    child: GlassButton(
                      text: "Read Note",
                      reading: _controller.readingText.value,
                      onTap: () async {
                        if (_controller.imageFilePath.value.isNotEmpty) {
                          _controller.readingText.value = true;
                          await _controller.extractTextFromImage();
                          _controller.readingText.value = false;
                          _controller.isTextExtracted.value = true;
                        } else {
                          showDialogBox('Empty', "plaese select image first");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GlassButton extends StatelessWidget {
  const GlassButton({
    required this.text,
    required this.onTap,
    this.reading = false,
    super.key,
  });
  final String text;
  final Function() onTap;
  final bool reading;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: getscreenSize(context).width * .6,
            height: getscreenSize(context).height * .07,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                width: 2,
                color: const Color(0xFF0E2954),
              ),
            ),
            child: Center(
              child: reading
                  ? const Center(child: CircularProgressIndicator())
                  : Text(
                      text,
                      style: GoogleFonts.roboto(
                        color: const Color(0xFF0E2954),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class SelectedImageViewer extends StatelessWidget {
  const SelectedImageViewer({
    super.key,
    required this.path,
  });

  final String path;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // border: Border.all(width: 1, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      width: getscreenSize(context).width * .7,
      height: getscreenSize(context).height * .2,
      child: Center(
        child: Image.file(
          File(path),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
