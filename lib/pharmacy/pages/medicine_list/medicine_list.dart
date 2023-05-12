import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/pharmacy/controllers/medicine/list_controller.dart';
import 'package:pharma_go_v2_app/pharmacy/pages/medicine_list/my_component/medicine_card.dart';

class MedicineList extends StatelessWidget {
  MedicineList({super.key});

  final ListController _controller = Get.put<ListController>(ListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _controller.medicineList(),
        builder: (context, snapshot) => snapshot.data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            // : Text(snapshot.data!.length.toString())
            : ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => MedicineListCard(
                      index: index,
                      dataMapList: snapshot.data ?? [],
                    )
                // ListTile(
                //   title: Text(snapshot.data![index]['name']),
                //   trailing: Text(snapshot.data![index]['quantity']),
                //   subtitle: Text(snapshot.data![index]['dosage']),
                //   contentPadding:
                //       const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                //   shape: Border.all(width: 1, color: Colors.black),
                // ),
                ),
      ),
//!---------------------------------------------------------------
    );
  }
}
