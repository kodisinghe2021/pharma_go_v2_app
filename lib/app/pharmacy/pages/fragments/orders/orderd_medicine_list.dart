import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/pharmacy/controllers/orders/orders_controller.dart';
import 'package:pharma_go_v2_app/app/pharmacy/pages/fragments/orders/components/orderd_medicine_card.dart';

class OrderdMedicineList extends StatelessWidget {
  OrderdMedicineList({super.key});
  final OrdersController _controller =
      Get.put<OrdersController>(OrdersController());
  
   final MedicineListCardControllder _controllerM =
      Get.put<MedicineListCardControllder>(MedicineListCardControllder());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.back();
          },
          child: const Icon(Bootstrap.back),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: _controller.retrieveMedicineData(),
          builder: (context, snapshot) => snapshot.data == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  width: size.width,
                  height: size.height * .9,
                  child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return OrderedMedicineListCard(
                          dataMap: snapshot.data![index],
                        );
                      }),
                ),
        ),
      ),
    );
  }
}
