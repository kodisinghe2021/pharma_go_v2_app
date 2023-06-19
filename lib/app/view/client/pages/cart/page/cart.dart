import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/cart/controller/cart_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class CartPage extends GetView<CartController> {
  CartPage({super.key});

  final CartController _controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Cart'),
      ),
      body: Obx(
        () => Stack(
          children: [
            SizedBox(
              width: screenSize.width,
              height: double.infinity,
              child: Image.asset(
                'assets/images/cart.jpg',
                fit: BoxFit.cover,
              ),
            ),
            // Positioned(
            //     bottom: 5,
            //     right: 5,
            //     child: Text(
            //       _controller.itemCount.value.toString(),
            //       style: GoogleFonts.roboto(fontSize: 10),
            //     )),
            _controller.itemCount.value > 0
                ? Positioned(
                    top: getscreenSize(context).height * .01,
                    child: SizedBox(
                      width: getscreenSize(context).width,
                      height: getscreenSize(context).height * .9,
                      child: ListView.builder(
                        itemCount: _controller.getCartList().length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 10),
                          width: getscreenSize(context).width * .9,
                          height: getscreenSize(context).height * .1,
                          decoration: BoxDecoration(
                            color: Colors.amberAccent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: ListTile(
                                  title: Text(
                                      "Pharmacy name-- ${_controller.getCartList()[index].pharmacyName}"),
                                  subtitle: Text(
                                      "Medicine name-- ${_controller.getCartList()[index].medicineName}"),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  onTap: () async {
                                    Logger().i("tepped - $index");
                                    await _controller.addOrder(index);
                                    _controller.getCartList().removeAt(index);

                                    _controller.itemCount.value =
                                        _controller.getCartList().length;
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                      ),
                                      color: Colors.greenAccent,
                                    ),
                                    child: const Text('Order'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      "No Data",
                      style: GoogleFonts.roboto(
                          fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
