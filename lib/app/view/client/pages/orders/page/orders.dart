import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/orders/controller/orders_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class OrdersPage extends GetView<OrderController> {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: getscreenSize(context).width,
            height: double.infinity,
            child: Image.asset(
              'assets/images/cart.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: getscreenSize(context).height * .07,
            child: SizedBox(
              width: getscreenSize(context).width,
              height: getscreenSize(context).height * .9,
              // child: ListView.builder(
              //   itemCount: controller.getCartList().length,
              //   itemBuilder: (context, index) => ListTile(
              //     tileColor: Colors.amber,
              //     title: Text(
              //         "Pharmacy name-- ${controller.getCartList()[index].pharmacyName}"),
              //     subtitle: Text(
              //         "Medicine name-- ${controller.getCartList()[index].medicineName}"),
              //   ),
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
