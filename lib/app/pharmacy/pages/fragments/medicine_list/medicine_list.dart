import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/pharmacy/controllers/medicine/list_controller.dart';

class MedicineList extends StatelessWidget {
  MedicineList({super.key});

  final PharmaMedListController _controller =
      Get.put<PharmaMedListController>(PharmaMedListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _controller.getList(),
        builder: (context, snapshot) => snapshot.data == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => SizedBox(
                  height: 200,
                  width: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('id -- ${snapshot.data![index]['medicineID']}'),
                      Text('name -- ${snapshot.data![index]['medicineName']}'),
                      Text('dosage -- ${snapshot.data![index]['dosage']}'),
                      Text('Price -- ${snapshot.data![index]['price']}'),
                      Text(
                          'quantity -- ${snapshot.data![index]['availableQuantity']}'),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
