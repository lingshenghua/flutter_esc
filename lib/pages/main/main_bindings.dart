import 'package:flutter_esc/pages/main/main_controller.dart';
import 'package:get/get.dart';


class MainBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(() => MainController());
  }
}
