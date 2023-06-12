import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/widgets/medicine_pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/widgets/top_bar.dart';
import 'package:pharma_go_v2_app/app/view_model/client/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  HomePage({super.key});

  final HomeController _controller = Get.put(HomeController());

  //* build method
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
//------ bottom naviagation bar
      bottomNavigationBar: HomeBottomNavBar(),
//------ bottom naviagation bar END

//------ Body
      body: Obx(
        () => Column(
          children: [
//---- visible area 01
            Visibility(
              visible: _controller.imageFilePath.value.isNotEmpty &&
                  !_controller.isPharmacyOpen.value,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.black),
                    borderRadius: BorderRadius.circular(10)),
                // decoration: const BoxDecoration(color: Colors.amber),
                width: screenSize.width,
                height: screenSize.height * .3,
                child: Center(
                  child: Image.file(
                    File(_controller.imageFilePath.value),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),

            // this data will be apear only if text is extracted
            Visibility(
              visible: _controller.isTextExtracted.value &&
                  !_controller.isPharmacyOpen.value,
              child: Container(
                decoration: const BoxDecoration(color: Colors.blue),
                width: screenSize.width,
                height: screenSize.height * .4,
                child: ListView.builder(
                  itemCount: _controller.textMapList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading:
                        Text(_controller.textMapList[index]['days'].toString()),
                    title:
                        Text(_controller.textMapList[index]['name'].toString()),
                    subtitle: Text(
                        _controller.textMapList[index]['dosage'].toString()),
                  ),
                ),
              ),
            ),
//---------------------------------------------------------- visible area 01 END

//---------------------------------------------------------- visible area 02
            // this is the result list
            Visibility(
              visible: _controller.isTextExtracted.value &&
                  _controller.isPharmacyOpen.value,
              child: SizedBox(
                width: screenSize.width,
                height: screenSize.height * .7,
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _controller.setData(),
                  builder: (context, snapshot) {
                    // if snapshot has error then this
                    if (snapshot.hasError) {
                      return showDialogBox('Somthing went wrong', 'try again');
                    }

                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) => MedicinePharmacyCard(
                          snapshotData: snapshot.data,
                          pharmacyCardIndex: index,
                        ),
                      );
                    }

                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            ),
            //---------------------------------------------------------- visible area 02 END
          ],
        ),
      ),
    );
  }
}

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
