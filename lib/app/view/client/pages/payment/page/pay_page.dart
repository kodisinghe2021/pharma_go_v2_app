import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view/client/pages/payment/controller/pay_controller.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class PayPage extends GetView<PayController> {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pay Here'),
        ),
        body: Stack(
          children: [
            SizedBox(
              width: getscreenSize(context).width,
              height: double.maxFinite,
              child: Image.asset(
                'assets/images/history.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: InkWell(
                onTap: () async {
                  await controller.saveDataToPharmacy();
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: getscreenSize(context).width * .9,
                  height: getscreenSize(context).height * .28,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF00B4DB),
                        Color(0xFF0083B0),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(width: .5, color: Colors.black),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/cod.png',
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                      ),
                      const Expanded(
                        child: Text('Pay after you got the order'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
