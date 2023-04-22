import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pharma_go_v2_app/controllers/home/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  //* build method
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      //^ Appbar
      appBar: AppBar(
        title: const Text("image Reading"),
        centerTitle: true,
      ),

      //^ body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: screenSize.width,
          height: screenSize.height,
          child: Obx(
            () =>  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (controller.textScanning.value) const CircularProgressIndicator(),
                if (!controller.textScanning.value && controller.imageFile == null)
                  Container(
                    width: screenSize.width * .9,
                    height: screenSize.width * 1.35,
                    color: Colors.blueGrey,
                  ),
                if (controller.imageFile != null)
                  SizedBox(
                    width: screenSize.width * .9,
                    height: screenSize.width * 1.35,
                    child: Image.file(
                      File(controller.imageFile!.path),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        controller.getImage(ImageSource.gallery);
                      },
                      child: const Text('Gallery'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.getImage(ImageSource.camera);
                      },
                      child: const Text('Camera'),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.getRecognisedText(controller.imageFile);
                  },
                  child: const Text('Read image'),
                ),
                Text(controller.scannedText.value),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
