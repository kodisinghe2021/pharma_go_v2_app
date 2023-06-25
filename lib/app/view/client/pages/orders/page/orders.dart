import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/history/widgets/history_card.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/orders/controller/orders_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class OrdersPage extends GetView<OrderController> {
  OrdersPage({super.key});
  final OrderController _controller =
      Get.put<OrderController>(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: getscreenSize(context).width,
            height: double.infinity,
            child: Image.asset(
              'assets/images/medicine.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: FutureBuilder<
                List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
              future: _controller.getOrderData(),
              builder: (context, snapshot) {
                if (snapshot.data!.isEmpty) {
                  const Center(
                    child: Text("No data"),
                  );
                }

                if (snapshot.data!.isNotEmpty) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => OrderCard(
                      cartModel: CartModel.fromJson(
                        json: snapshot.data![index].data(),
                      ),
                    ),
                  );
                }

                return const Center(
                  child: Text("No data"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
