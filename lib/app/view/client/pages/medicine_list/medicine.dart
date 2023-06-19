import 'package:flutter/material.dart';
import 'package:pharma_go_v2_app/supports/constant/box_constraints.dart';

class MedicinePage extends StatelessWidget {
  const MedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: getscreenSize(context).width,
            height: double.infinity,
            child: Image.asset(
              'assets/images/history.jpg',
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Text("Medicine Page"),
          ),
        ],
      ),
    );
  }
}
