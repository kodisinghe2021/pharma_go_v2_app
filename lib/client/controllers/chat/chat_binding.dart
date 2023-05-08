import 'package:get/get.dart';
import 'package:pharma_go_v2_app/client/controllers/chat/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ChatController());
  }
}
