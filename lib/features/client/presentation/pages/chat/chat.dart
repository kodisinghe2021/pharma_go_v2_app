import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/features/client/controllers/chat/chat_controller.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});

 final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
            child: Text("Chat Page:- ${controller.num.value}"),
          ),
        ],
      ),
    );
  }
}
