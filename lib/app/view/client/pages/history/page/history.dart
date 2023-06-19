import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/model/client/cart/cart_model.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/history/controller/history_controller.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/history/widgets/history_card.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class HistoryPage extends GetView<HistoryController> {
  HistoryPage({super.key});

  final HistoryController _controller =
      Get.put<HistoryController>(HistoryController());
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenSize.width,
            height: double.infinity,
            child: Image.asset(
              'assets/images/history.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            child: SizedBox(
              width: getscreenSize(context).width,
              height: getscreenSize(context).height * 8,
              child: StreamBuilder<QuerySnapshot<Object?>>(
                stream: _controller.getOrderData(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }

                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      CartModel model = CartModel.fromJson(
                          json: document.data()! as Map<String, dynamic>);

                      return HistoryCard(
                        cartModel: model,
                        statusCode: 0,
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
