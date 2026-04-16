import 'package:super_get/super_get.dart';

import 'api_demo_controller.dart';

class ApiDemoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ApiDemoController());
  }
}
