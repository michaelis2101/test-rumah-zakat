import 'package:get/get.dart';

class UserController extends GetxController {
  RxString username = ''.obs;

  void setUsername(String param) {
    username.value = param;
  }
}
