import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class MedicineDetails extends GetView<MedicineDetailsController> {
  const MedicineDetails({super.key});

  @override
  Widget build(BuildContext context) {
    controller.medicineName.value = Get.arguments;
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => controller.getWebsiteData(),
      // ),
      appBar: AppBar(
        title: Text(controller.medicineName.value),
        centerTitle: true,
      ),
      body: Obx(
        () => controller.descrip01.isEmpty || controller.descrip02.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    Text(
                      'The Description of ${controller.medicineName.value}',
                      style: GoogleFonts.roboto(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Text(controller.descrip01.value),
                    const SizedBox(height: 10),
                    Text(controller.descrip02.value),
                    const SizedBox(height: 10),
                    Text(controller.descrip03.value),
                    const SizedBox(height: 10),
                    Text(controller.descrip04.value),
                    const SizedBox(height: 10),
                    Text(controller.descrip05.value),
                  ],
                ),
              ),
      ),
    );
  }
}

//!---------------------------------------------------------controller
class MedicineDetailsController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    getWebsiteData();
  }

  var medicineName = ''.obs;

  String getUri() =>
      "https://www.drugs.com/${medicineName.value.toString().toLowerCase()}.html";

  var descrip01 = ''.obs;
  var descrip02 = ''.obs;
  var descrip03 = ''.obs;
  var descrip04 = ''.obs;
  var descrip05 = ''.obs;

  Future<void> getWebsiteData() async {
    final url = Uri.parse(getUri().toString()); //Metoprolol
    final responce = await http.get(url);
    dom.Document html = dom.Document.html(responce.body);
    final titles = html
        .querySelectorAll('p')
        .map((element) => element.innerHtml.trim())
        .toList();
    Logger().i("Count - ${titles.length}");

    int i = 0;
    for (var element in titles) {
      Logger().d("$i -->> $element");
      i++;
    }

    descrip01.value = titles[1];
    descrip02.value = titles[2];
    descrip03.value = titles[3];
    descrip04.value = titles[4];
    descrip05.value = titles[5];
  }

  //*-------------------------------------to do
  String htmlData = """descrip01.value = titles[1]""";
}

//!---------------------------------------------------------binding
class MedicineDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MedicineDetailsController>(MedicineDetailsController());
  }
}
