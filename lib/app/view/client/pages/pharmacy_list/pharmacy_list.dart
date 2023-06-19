import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/model/pharmacy_card.dart';
import 'package:pharma_go_v2_app/app/view/client/components/alert_boxes/get_alert.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/pharmacy_list/components/pharmacy_card_comp.dart';
import 'package:pharma_go_v2_app/app/view_model/client/pharmacy_list/pharmacy_list_controller.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';

class PharmacyListPage extends StatelessWidget {
  PharmacyListPage({super.key});
  final PharmacyListController _controller =
      Get.put<PharmacyListController>(PharmacyListController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pharmacy list'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.amber,
            ),
            width: 40,
            height: 40,
            child: Center(
              child: IconButton(
                onPressed: () {
                  Get.toNamed(Routes.CARTPAGE);
                },
                icon: const Icon(Bootstrap.cart2),
              ),
            ),
          )
        ],
      ),
      
      body: FutureBuilder<List<PharmacyCardModel>>(
        future: _controller.getData(),
        builder: (context, snapshot) {
          // if snapshot has error then this
          if (snapshot.hasError) {
            return showDialogBox('Somthing went wrong', 'try again');
          }

          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => PharmacyCardComp(
                pharmacyCardModel: snapshot.data![index],
                pharmacyCardIndex: index,
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
