import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PayPage extends GetView {
  const PayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pay Here'),
      ),
    );
  }
}
