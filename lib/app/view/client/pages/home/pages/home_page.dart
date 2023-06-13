import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/widgets/bottom_nav_bar.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/home/widgets/medicine_pharmacy_card.dart';
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
            //--- this will shows the selected image
            Visibility(
              visible: _controller.imageFilePath.value.isNotEmpty &&
                  !_controller.isPharmacyOpen.value,
              child: SelectedImageViewer(path: _controller.imageFilePath.value),
            ),
            const SizedBox(height: 5),

            // this data will be apear only if text is extracted
            Visibility(
              visible: _controller.isTextExtracted.value &&
                  !_controller.isPharmacyOpen.value,
              child: SizedBox(
                // decoration: const BoxDecoration(color: Colors.blue),
                width: screenSize.width,
                height: screenSize.height * .4,
                child: ListView.builder(
                  itemCount: _controller.extractedCharObjectList.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Text(_controller
                        .extractedCharObjectList[index].days
                        .toString()),
                    title: Text(_controller.extractedCharObjectList[index].name
                        .toString()),
                    subtitle: Text(_controller
                        .extractedCharObjectList[index].dosageInNote
                        .toString()),
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
                child: FutureBuilder<List<PharmacyCard>>(
                  future: _controller.getData(),
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

class SelectedImageViewer extends StatelessWidget {
  const SelectedImageViewer({
    super.key,
    required this.path,
  });

  final String path;
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      width: screenSize.width,
      height: screenSize.height * .3,
      child: Center(
        child: Image.file(
          File(path),
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
