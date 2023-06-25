import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/medicine_list/controllers/medicine_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';
import 'package:pharma_go_v2_app/supports/routes/app_pages.dart';

class MedicinePage extends StatelessWidget {
  MedicinePage({super.key});
  final MedicineController _controller =
      Get.put<MedicineController>(MedicineController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Obx(
          () => SizedBox(
            width: getscreenSize(context).width,
            height: getscreenSize(context).height * .95,
            child: Stack(
              children: [
                SizedBox(
                  width: getscreenSize(context).width,
                  height: double.infinity,
                  child: Image.asset(
                    'assets/images/history.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  children: [
                    SizedBox(
                      height: getscreenSize(context).height * .06,
                    ),
                    SizedBox(
                      height: getscreenSize(context).height * .08,
                      width: getscreenSize(context).width * .9,
                      child: TextField(
                        controller: _controller.searchingText,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            _controller.medNameObs.value = value;
                          }
                          if (value.isEmpty) {
                            _controller.medNameObs.value = '';
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: const Icon(Bootstrap.search),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red, //this has no effect
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          hintText: "Search medicine name here ...",
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getscreenSize(context).width,
                      height: getscreenSize(context).height * .7,
                      child:
                          FutureBuilder<List<QueryDocumentSnapshot<Object?>>>(
                        future: _controller.searchData(),
                        builder: (context, snapshot) {
                          if (snapshot.data != null) {
                            if (_controller.medNameObs.value.isEmpty) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  Map<String, dynamic> dataMap =
                                      snapshot.data![index].data()
                                          as Map<String, dynamic>;
                                  return ListTile(
                                    title: Text(dataMap['name']),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.MDETAILS,  arguments: dataMap['name']);
                                      },
                                      icon: const Icon(
                                        Bootstrap.lightbulb_fill,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            if (_controller.medNameObs.value.isNotEmpty) {
                              for (var i = 0; i < snapshot.data!.length; i++) {
                                Map<String, dynamic> map = snapshot.data![i]
                                    .data() as Map<String, dynamic>;

                                if (map['name']
                                    .toString()
                                    .startsWith(_controller.medNameObs.value)) {
                                  return ListTile(
                                    title: Text(map['name']),
                                    trailing: IconButton(
                                      onPressed: () {
                                        Get.toNamed(Routes.MDETAILS, arguments: map['name']);
                                      },
                                      icon: const Icon(
                                        Bootstrap.lightbulb_fill,
                                        color: Colors.amber,
                                      ),
                                    ),
                                  );
                                }
                              }

                              // return ListView.builder(
                              //   itemCount: 1,
                              //   itemBuilder: (context, index) {
                              //     Map<String, dynamic> dataMap =
                              //         snapshot.data![index].data()
                              //             as Map<String, dynamic>;

                              //     if (dataMap['name']
                              //         .toString()
                              //         .startsWith(_controller.medNameObs)) {
                              //       return Text(dataMap['name']);
                              //     } else {
                              //       return Text(
                              //         'no matching item with ${_controller.medNameObs}',
                              //       );
                              //     }
                              //   },
                              // );
                            }
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                      // child: StreamBuilder<QuerySnapshot>(
                      //   stream: _controller.medicineStream(),
                      //   builder: (BuildContext context,
                      //       AsyncSnapshot<QuerySnapshot> snapshot) {
                      //     if (snapshot.hasError) {
                      //       return const Text('Something went wrong');
                      //     }

                      //     if (snapshot.connectionState ==
                      //         ConnectionState.waiting) {
                      //       return const Text("Loading");
                      //     }

                      //     if (snapshot.data!.docs.isEmpty) {
                      //       return const Center(
                      //           child: CircularProgressIndicator());
                      //     }

                      //     return ListView.builder(
                      //         itemCount: _controller.medicineStream(),
                      //         itemBuilder: (context, index) {
                      //           Logger().i("listview");
                      //           Logger().i(
                      //               "list is -${_controller.searchedList.first}");
                      //           String medName = _controller.medNameObs.value;
                      //           Map<String, dynamic> data =
                      //               snapshot.data!.docs[index].data()
                      //                   as Map<String, dynamic>;

                      //           if (medName.isNotEmpty) {
                      //             if (data['name']
                      //                 .toString()
                      //                 .contains(_controller.medNameObs.value)) {
                      //               _controller.searchedList.add(
                      //                 data['name'].toString(),
                      //               );
                      //               return ListTile(
                      //                 title: Text(
                      //                   _controller.searchedList.first,
                      //                 ),
                      //               );
                      //             }
                      //             return const Text("No Data");
                      //           }

                      //           return ListView.builder(
                      //             itemBuilder: (context, index) =>
                      //                 Text(data[index]['name']),
                      //           );
                      //         });
                      //   },
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(_controller.medNameObs.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
