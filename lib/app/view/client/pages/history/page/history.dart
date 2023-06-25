import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/history/controller/history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  HistoryPage({super.key});

  final HistoryController _controller =
      Get.put<HistoryController>(HistoryController());
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        // body: Stack(
        //   children: [
        //     SizedBox(
        //       width: getscreenSize(context).width,
        //       height: double.infinity,
        //       child: Image.asset(
        //         'assets/images/history.jpg',
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(top: 50),
        //       child: FutureBuilder<
        //           List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
        //         future: _controller.getOrderData(),
        //         builder: (context, snapshot) {
        //           if (snapshot.data!.isEmpty) {
        //             const Center(
        //               child: Text("No data"),
        //             );
        //           }

        //           if (snapshot.data!.isNotEmpty) {
        //             return ListView.builder(
        //               itemCount: snapshot.data!.length,
        //               itemBuilder: (context, index) => OrderCard(
        //                 cartModel: CartModel.fromJson(
        //                   json: snapshot.data![index].data(),
        //                 ),
        //               ),
        //             );
        //           }

        //           return const Center(
        //             child: Text("No data"),
        //           );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
