import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: const [
          // SizedBox(
          //   width: double.infinity,
          //   height: double.infinity,
          //   child: Image.asset(
          //     'assets/images/scat.png',
          //     fit: BoxFit.cover,
          //     height: double.infinity,
          //     width: double.infinity,
          //   ),
          // ),
          Center(
            child: Text("History Page"),
          ),
        ],
      ),
    );
  }
}
