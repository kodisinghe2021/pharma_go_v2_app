import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class PayPage extends GetView {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pay Here'),
        ),
        body: Container(
          width: getscreenSize(context).width,
          height: double.maxFinite,
          color: Colors.cyan,
        ),
      ),
    );
  }
}
