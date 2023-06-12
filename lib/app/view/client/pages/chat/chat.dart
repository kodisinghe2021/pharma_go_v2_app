import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pharma_go_v2_app/app/view_model/client/chat/chat_controller.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});

 final ChatController controller = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Text("Chat Page:- ${controller.num.value}"),
          ),
        ],
      ),
    );
  }
}
