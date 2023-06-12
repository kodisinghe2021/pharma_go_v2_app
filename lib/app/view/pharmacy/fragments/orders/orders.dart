import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view/pharmacy/fragments/orders/components/orders_card.dart';
import 'package:pharma_go_v2_app/app/view_model/pharmacy/orders/orders_controller.dart';

class OrdersPage extends StatelessWidget {
  OrdersPage({super.key});
  final OrdersController _controller = Get.put(OrdersController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _controller.getNewOrders(),
        builder: (context, snapshot) {
          //if streaming has error
          if (snapshot.hasError) {
            return Center(
              child: Text('Error..${snapshot.error.toString()}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(
                  child: Text('please wait data is loading'),
                ),
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) => OrdersCard(
              list: snapshot.data!.docs,
              index: index,
            ),
          );
        },
      ),
    );
  }
}
